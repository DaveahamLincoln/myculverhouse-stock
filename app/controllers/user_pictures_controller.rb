class UserPicturesController < ApplicationController
  # GET /user_pictures
  # GET /user_pictures.json
  def index
    @user_pictures = UserPicture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_pictures }
    end
  end

  # GET /user_pictures/1
  # GET /user_pictures/1.json
  def show
    @user_picture = UserPicture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_picture }
    end
  end

  # GET /user_pictures/new
  # GET /user_pictures/new.json
  def new
    @user_picture = UserPicture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_picture }
    end
  end

  # GET /user_pictures/1/edit
  def edit
    @user_picture = UserPicture.find(params[:id])
  end

  # POST /user_pictures
  # POST /user_pictures.json
  def create
    @user_picture = UserPicture.new(params[:user_picture])

    respond_to do |format|
      if @user_picture.save
        format.html { redirect_to @user_picture, notice: 'User picture was successfully created.' }
        format.json { render json: @user_picture, status: :created, location: @user_picture }
      else
        format.html { render action: "new" }
        format.json { render json: @user_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_pictures/1
  # PUT /user_pictures/1.json
  def update
    @user_picture = UserPicture.find(params[:id])

    respond_to do |format|
      if @user_picture.update_attributes(params[:user_picture])
        format.html { redirect_to @user_picture, notice: 'User picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_pictures/1
  # DELETE /user_pictures/1.json
  def destroy
    @user_picture = UserPicture.find(params[:id])
    @user_picture.destroy

    respond_to do |format|
      format.html { redirect_to user_pictures_url }
      format.json { head :no_content }
    end
  end
end
