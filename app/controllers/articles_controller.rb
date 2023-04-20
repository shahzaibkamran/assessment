class ArticlesController < ApplicationController
  before_action :validate_admin, only: %i[update destroy]
  before_action :set_article, only: %i[ show update destroy ]

  def index
    @articles = Article.all

    render json: @articles
  end

  def show
    render json: @article
  end

  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:description,:url,:urlToImage,:content)
  end
end
