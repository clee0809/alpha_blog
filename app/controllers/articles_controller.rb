class ArticlesController < ApplicationController
  def show
    # debugger
    # retreive article by id
    @article = Article.find(params[:id]) #params: hash data from front end
    
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new # to prevent nil error on new view when check error
  end

  def edit
    # debugger
    @article = Article.find(params[:id])
  end


  def create
    # Parameters: {"authenticity_token"=>"[FILTERED]", "article"=>{"title"=>"hello", "description"=>"dsdfsdfs"}, "commit"=>"Save Article"}
    @article = Article.new(params.require(:article).permit(:title, :description))
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
    @article = Article.find(params[:id]) # article to be updated
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfully."
      redirect_to article_path(@article) 
    else
      render "edit" , status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
end