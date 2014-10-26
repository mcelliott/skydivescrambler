class Teams::ParticipantController < ApplicationController
  authorize_resource
  before_action :authenticate_user!

  def new
    current_event
    current_team
    @team_participant = TeamParticipant.new
  end

  def create
    @participant = current_user.team_participants.build(team: current_team,
                                                        event: current_event,
                                                        participant: current_participant,
                                                        placeholder: participant_params[:placeholder])

    respond_to do |format|
      if @participant.save
        format.html { redirect_to event_path(current_participant.event), notice: 'Participant was successfully added.' }
      else
        format.html { redirect_to event_path(current_participant.event), notice: 'Failed to add participant' }
      end
    end
  end

  def destroy
    team_participant = current_team.team_participants.find params[:id]
    team_participant.destroy
    respond_to do |format|
      format.html { redirect_to event_path(team_participant.event), notice: 'Participant was successfully destroyed.' }
    end
  end

  private

  def next_participant
    current_event.participants.count + 1
  end

  def current_event
    @event ||= Event.find params[:event_id]
  end

  def current_team
    @team ||= current_user.teams.find params[:team_id]
  end

  def current_participant
    current_user.participants.find participant_params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def participant_params
    params.require(:team_participant).permit(:id, :category_id, :placeholder)
  end
end