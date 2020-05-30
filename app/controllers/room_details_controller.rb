class RoomDetailsController < ApplicationController
  include Pagy::Backend
  include Recorder
  include Joiner
  include Emailer
  include Populator

  def index
    
  end

  def start
    logger.info "Support: #{current_user.email} is starting room #{@room.uid}"

    # Join the user in and start the meeting.
    opts = default_meeting_options
    opts[:user_is_moderator] = true

    # Include the user's choices for the room settings
    @room_settings = JSON.parse(@room[:room_settings])
    opts[:mute_on_start] = room_setting_with_config("muteOnStart")
    opts[:require_moderator_approval] = room_setting_with_config("requireModeratorApproval")

    begin
      redirect_to join_path(@room, current_user.name, opts, current_user.uid)
    rescue BigBlueButton::BigBlueButtonException => e
      logger.error("Support: #{@room.uid} start failed: #{e}")

      redirect_to room_path, alert: I18n.t(e.key.to_s.underscore, default: I18n.t("bigbluebutton_exception"))
    end

    # Notify users that the room has started.
    # Delay 5 seconds to allow for server start, although the request will retry until it succeeds.
    NotifyUserWaitingJob.set(wait: 5.seconds).perform_later(@room)
  end  

  # Find the room from the uid.
  def find_room
    print params
    @room = Room.includes(:owner).find_by!(uid: params[:room_uid])
  end

  def create
    print "Apple "
  end

  # GET /:room_uid/room_settings
  def room_settings
    @room = Room.includes(:owner).find_by!(uid: params[:format])
    @room_checkbox_settings = JSON.parse(@room.room_settings)
  end

  # POST /:room_uid/update_settings
  def update_settings
    begin
      
      print "======================================= Update Params \n"
      print  params[:room]["uid"]
      @room = Room.includes(:owner).find_by!(uid: params[:room]["uid"])
      options = params[:room].nil? ? params : params[:room]
      raise "Room name can't be blank" if options[:name].blank?

      # Update the rooms values
      room_settings_string = create_room_settings_string(options)

      @room.update_attributes(
        name: options[:name],
        room_settings: room_settings_string,
        access_code: options[:access_code],
        website_url: options[:website_url],
        video_url: options[:video_url], 
        invite_emails: options[:invite_emails], 
        upload_pdf: options[:upload_pdf], 
        upload_ppt: options[:upload_ppt], 
        meeting_datetime: options[:meeting_datetime], 
        background_color: options[:background_color]
      )

      # Redirect to room is auto join was not turned on
      return redirect_to @room,
        flash: { success: I18n.t("room.update_settings_success") } unless room_params[:auto_join] == "1"

      # Start the room if auto join was turned on
      start
        # flash[:success] = I18n.t("room.update_settings_success")
    rescue => e
      logger.error "Support: Error in updating room settings: #{e}"
      flash[:alert] = I18n.t("room.update_settings_error")
    end
    
    # redirect_back fallback_location: room_path(@room)
  end  

  # POST /
  def test
    # Return to root if user is not signed in
    return redirect_to root_path unless current_user

    # Check if the user has not exceeded the room limit
    return redirect_to current_user.main_room, flash: { alert: I18n.t("room.room_limit") } if room_limit_exceeded

    # Create room
    print "----------------------------------------------------------------------\n"
    print  Time.zone.parse(room_params[:meeting_datetime].to_s).utc
    print "----------------------------------------------------------------------\n"
    meeting_datetime = Time.zone.parse(room_params[:meeting_datetime].to_s).utc
    @room = Room.new(name: room_params[:name], access_code: room_params[:access_code], website_url: room_params[:website_url], video_url: room_params[:video_url], upload_pdf: room_params[:upload_pdf], upload_ppt: room_params[:upload_ppt], invite_emails: room_params[:invite_emails], meeting_datetime: meeting_datetime, background_color: room_params[:background_color])
    @room.owner = current_user
    @room.room_settings = create_room_settings_string(room_params)

    # Save the room and redirect if it fails
    return redirect_to current_user.main_room, flash: { alert: I18n.t("room.create_room_error") } unless @room.save

    print "++++++++++++++++++++++++++++++++++++++\n\n\n"
    print request.base_url + @room.invite_path + "\n"
    print current_user.name + " \n"
    print "++++++++++++++++++++++++++++++++++++++\n\n\n"
    
    #Send Invitation
    emails = room_params[:invite_emails].split(",")
    emails.each do |email|
      print email
      send_user_invitation_email(current_user.name, email, request.base_url + @room.invite_path, room_params[:meeting_datetime])
    end

    logger.info "Support: #{current_user.email} has created a new room #{@room.uid}."
  

    # Redirect to room is auto join was not turned on
    return redirect_to @room,
      flash: { success: I18n.t("room.create_room_success") } unless room_params[:auto_join] == "1"

    # Start the room if auto join was turned on
    start
  end
  
  def create_room_settings_string(options)
    room_settings = {
      "muteOnStart": options[:mute_on_join] == "1",
      "requireModeratorApproval": options[:require_moderator_approval] == "1",
      "anyoneCanStart": options[:anyone_can_start] == "1",
      "joinModerator": options[:all_join_moderator] == "1",
    }

    room_settings.to_json
  end  

  def room_limit_exceeded
    limit = @settings.get_value("Room Limit").to_i

    # Does not apply to admin or users that aren't signed in
    # 15+ option is used as unlimited
    return false if current_user&.has_role?(:admin) || limit == 15

    current_user.rooms.length >= limit
  end  

  def room_params
    params.require(:room).permit(:name, :auto_join, :mute_on_join, :access_code,
      :require_moderator_approval, :anyone_can_start, :all_join_moderator,
       :website_url, :video_url, :invite_emails, :upload_pdf, :upload_ppt, :meeting_datetime, :background_color)
  end
end

