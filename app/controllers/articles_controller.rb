class ArticlesController < ApplicationController
  # create method set_article, and call it here for DRY, 
  # it will be called before the specified action in only: []
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
    # debugger
    # retreive article by id
     #params: hash data from front end    
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new # to prevent nil error on new view when check error
  end

  def edit
    # debugger
    
  end


  def create
    # Parameters: {"authenticity_token"=>"[FILTERED]", "article"=>{"title"=>"hello", "description"=>"dsdfsdfs"}, "commit"=>"Save Article"}
    @article = Article.new(article_params)
    # render plain: @article.inspect
    if @article.save
      flash[:notice] = "Article was created successfully."
      # save method returns false when something went wrong
      # redirect to show page with article id (Article object) which just created and saved
      # redirect_to article_path(@article)
      redirect_to @article #: shortcut for article_path(@article)
    else # check validation
      render 'new' , status: :unprocessable_entity
    end
  end

    # handle action after click update article button in edit page
  def update
     # article to be updated
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to article_path(@article) 
    else
      render "edit" , status: :unprocessable_entity
    end
  end

  def destroy    
    @article.destroy
    redirect_to articles_path
  end

  private # any method available only in this controller, not a block, no need 'end'
  def set_article 
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end