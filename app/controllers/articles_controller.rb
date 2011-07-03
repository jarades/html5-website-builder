class ArticlesController < ApplicationController

  before_filter :find_path, :only => [:publish, :index, :destroy]

  def publish
    @article = Article.find(params[:id])
    @article.content = RedCloth.new(@article.content).to_html.html_safe
    html = render_to_string(:template => "articles/template.html.haml", :layout => 'article' )
    FileUtils.makedirs(@file_path) unless File.exists?(@file_path)
    File.open("#{@file_path + @article.filename}.html", 'w') {|f| f.write(html) }
    @article.update_attribute(:published, true)
    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Built a webpage for the article \"#{@article.title}\"" }
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
    @settings = Setting.first
    FileUtils.remove_file("#{@file_path + @article.filename}.html", force = true)
    respond_to do |format|
      format.html { redirect_to articles_url }
    end
  end
  
  protected    
    def find_path
      @file_path = "#{Rails.root}/public/website/#{Setting.first.articles_directory}/"
      @url_path = "/website/#{Setting.first.articles_directory}/"
    end
end
