class RoomDetailsController < ApplicationController
  include Pagy::Backend
  include Recorder
  include Joiner
  include Emailer
  include Populator
  def index
    print "Bnana \n"
  end

  def create
    print "Apple "
  end

  # POST /
  def test
    # Return to root if user is not signed in
    return redirect_to root_path unless current_user

    # Check if the user has not exceeded the room limit
    return redirect_to current_user.main_room, flash: { alert: I18n.t("room.room_limit") } if room_limit_exceeded

    # Create room
    print "----------------------------------------------------------------------\n"
    print room_params
    print "----------------------------------------------------------------------\n"

    @room = Room.new(name: room_params[:name], access_code: room_params[:access_code], website_url: room_params[:website_url], video_url: room_params[:video_url], upload_pdf: room_params[:upload_pdf], upload_ppt: room_params[:upload_ppt], invite_emails: room_params[:invite_emails], meeting_datetime: room_params[:meeting_datetime], background_color: room_params[:background_color])
    @room.owner = current_user
    @room.room_settings = create_room_settings_string(room_params)

    # Save the room and redirect if it fails
    return redirect_to current_user.main_room, flash: { alert: I18n.t("room.create_room_error") } unless @room.save

    print "++++++++++++++++++++++++++++++++++++++\n\n\n"
    print request.base_url + @room.invite_path
    print "++++++++++++++++++++++++++++++++++++++\n\n\n"
    
    #Send Invitation
    emails = room_params[:invite_emails].split(",")
    emails.each do |email|
      print email
      send_user_invitation_email(room_params[:name], email, request.base_url + @room.invite_path)
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

