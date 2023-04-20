class AuthorsController < ApplicationController
  before_action :validate_admin, only: %i[ update destroy]
  before_action :set_author, only: %i[ show update destroy ]

  def index
    @authors = Author.all

    render json: @authors
  end

  def show
    render json: @author
  end

  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @author.destroy
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name)
  end
end
