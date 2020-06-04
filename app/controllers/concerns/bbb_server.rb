# frozen_string_literal: true

# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
#
# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
#
# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.

require 'bigbluebutton_api'

module BbbServer
  extend ActiveSupport::Concern
  include BbbApi

  META_LISTED = "gl-listed"

  # Checks if a room is running on the BigBlueButton server.
  def room_running?(bbb_id)
    bbb_server.is_meeting_running?(bbb_id)
  end

  # Returns a list of all running meetings
  def all_running_meetings
    bbb_server.get_meetings
  end

  def get_recordings(meeting_id)
    bbb_server.get_recordings(meetingID: meeting_id)
  end

  def get_multiple_recordings(meeting_ids)
    bbb_server.get_recordings(meetingID: meeting_ids)
  end

  # Returns a URL to join a user into a meeting.
  def join_path(room, name, options = {}, uid = nil)
    # Create the meeting, even if it's running
    start_session(room, options)
    
    # Determine the password to use when joining.
    password = options[:user_is_moderator] ? room.moderator_pw : room.attendee_pw

    # Generate the join URL.
    join_opts = {}
    join_opts[:userID] = uid if uid
    join_opts[:join_via_html5] = true
    join_opts[:guest] = true if options[:require_moderator_approval] && !options[:user_is_moderator]
    print "------------------------- Background color----------------------------- \n"
    if room.background_color
      bg_color = "body { background-color: "+ room.background_color.to_s
      bg_color += "!important;}"
    else
      "body { background-color: #06172A !important;}"
    end
    print bg_color

    join_opts[:"userdata-customStyle"] = bg_color
    
    bbb_server.join_meeting_url(room.bbb_id, name, password, join_opts)
  end

  # Creates a meeting on the BigBlueButton server.
  def start_session(room, options = {})
    create_options = {
      record: options[:meeting_recorded].to_s,
      logoutURL: options[:meeting_logout_url] || '',
      moderatorPW: room.moderator_pw,
      attendeePW: room.attendee_pw,
      moderatorOnlyMessage: options[:moderator_message],
      muteOnStart: options[:mute_on_start] || false,
      "meta_#{META_LISTED}": options[:recording_default_visibility] || false,
      "meta_bbb-origin-version": Greenlight::Application::VERSION,
      "meta_bbb-origin": "Greenlight",
      "meta_bbb-origin-server-name": options[:host],
    }

    create_options[:guestPolicy] = "ASK_MODERATOR" if options[:require_moderator_approval]
  
    modules = BigBlueButton::BigBlueButtonModules.new
    
    if room.upload_pdf.path
      modules.add_presentation(:file, room.upload_pdf.path)
    else

    end

    if room.upload_ppt.path
      modules.add_presentation(:file, room.upload_ppt.path)
    else

    end

    # modules.add_presentation(:filename, "dummy.pdf")
    # modules.add_presentation(:url, 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf', "dummy.pdf")

    # Send the create request.
    begin

      if room.upload_pdf.path
        print "Post api call for meeting create \n"
        meeting = bbb_server.create_meeting(room.name, room.bbb_id, create_options, modules)
      else
        print "Get api call for meeting create"
        meeting = bbb_server.create_meeting(room.name, room.bbb_id, create_options)
      end

      print meeting
      
      # Update session info.
      unless meeting[:messageKey] == 'duplicateWarning'
       room.update_attributes(sessions: room.sessions + 1,
          last_session: DateTime.now)
      end
    rescue BigBlueButton::BigBlueButtonException => e
      puts "BigBlueButton failed on create: #{e.key}: #{e.message}"
      raise e
    end
  end

  # Gets the number of recordings for this room
  def recording_count(bbb_id)
    bbb_server.get_recordings(meetingID: bbb_id)[:recordings].length
  end

  # Update a recording from a room
  def update_recording(record_id, meta)
    meta[:recordID] = record_id
    bbb_server.send_api_request("updateRecordings", meta)
  end

  # Deletes a recording from a room.
  def delete_recording(record_id)
    bbb_server.delete_recordings(record_id)
  end

  # Deletes all recordings associated with the room.
  def delete_all_recordings(bbb_id)
    record_ids = bbb_server.get_recordings(meetingID: bbb_id)[:recordings].pluck(:recordID)
    bbb_server.delete_recordings(record_ids) unless record_ids.empty?
  end
end
