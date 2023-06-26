class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  # para funcionar cuando el edit esta sin logearse lo envia a logearse
  before_action :authenticate_user!, except: [:index, :show]
  # No habilitar las opciones para el user que no lo creo, con el metodo def correct_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /friends or /friends.json
  def index
    # se agrega el codigo de pagy paginacion
    # @friends = Friend.all
    @pagy, @friends = pagy(Friend.all)
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    # @friend = Friend.new
    @friend = current_user.friends.build
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends or /friends.json
  def create
    # @friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend), notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized To Edit This Friend" if @friend.nil?

    # <!--Para no mostrar los botones al usuario que no lo creo antes de def correct_user
    #<% if friend.user == current_user%>
    #  <td ><%= link_to "Edit", edit_friend_path(friend), class:"btn btn-outline-warning" %></td>
    #  <td ><%= button_to "Destroy", friend, method: :delete, data: {turbo_method: :delete, turbo_confirm: "Mensaje: Estas seguro?"}, class:"btn btn-outline-danger" %></td>
    #<% else %>
    #  <td></td>
    #  <td></td>
    #<% end %>
    #-->
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      # Agregar el :user_id para que funcione
      params.require(:friend).permit(:fisrt_name, :last_name, :email, :phone, :twitter, :user_id)
    end
end
