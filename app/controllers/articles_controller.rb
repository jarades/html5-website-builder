class ArticlesController < ApplicationController

  def publish
    @article = Article.find(params[:id])
    
    html = render_to_string(:template => "articles/template.html.haml", :layout => 'article' )
    FileUtils.makedirs("#{Rails.root}/public/website/articles/") unless File.exists?("#{Rails.root}/public/website/articles/")
    File.open("#{Rails.root}/public/website/articles/#{@article.filename}.html", 'w') {|f| f.write(html) }

    respond_to do |format|
      format.html notice: 'Article page generated successfully.'
    end

  end

  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path, notice: 'Article was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to articles_path, notice: 'Article was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    FileUtils.remove_file("#{Rails.root}/public/website/articles/#{@article.filename}.html", force = true)
    respond_to do |format|
      format.html { redirect_to articles_url }
    end
  end
end
