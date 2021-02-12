require 'pry'
require_relative '../../config/environment'

# accounts
  #/accounts - let a user search through all their accounts, each one will be a link to that account's proposals
  #/accounts/:id - let a user search through all the proposals for a particular account id
# proposals
  #/proposal - let user select from existing models they want to go into the proposal
  #/proposal/:id/accessories/edit - all accessories have a qty of 0, user can change the qty
  #/proposal/:id/edit - shows the stored value for all quantities, user can edit, also can add models to the proposal
  #/proposal/:id/view - lets the user view the completed proposal, can't edit in this screen


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/model/:id' do 
    @model = Model.all.find(self.params[:id])
   

    erb :'index.html'
  end

  post '/model' do

  end
  
  get '/' do
    @models = Model.all
    @accounts = Account.all

    erb :'index.html'

  end

  post '/' do
    puts "There were #{Proposal.all.count} proposals."
    Proposal.create(account_id: Account.find(params[:account_id]).id)


    params.each do |k,v|
      if v == "on"
        Proposal.all.last.units.create(model_id: k.to_i)
      end
    end
    puts "Now there are #{Proposal.all.count} proposals."

    redirect to "proposals/#{Proposal.all.last.id}"
  end

  get '/proposals/:id/edit' do
    @proposal = Proposal.find(params[:id])

    erb :'edit_proposal.html'
  end

  get '/proposals/:id' do 
    @proposal = Proposal.find(params[:id])

    erb :'show_proposal.html'
  end


  post '/articlesparams' do
    binding.pry

  end
  patch '/articles/:id' do 
    id = params[:id]
    Article.find(id).update(title: params[:title], content: params[:content])

    redirect to "/articles/#{id}"
  end

  post '/articles' do
    new_article = Article.create(title: params[:title], content: params[:content])

    redirect to "/articles/#{new_article.id}"
  end

  delete "/articles/:id" do 
    article = Article.find(params[:id])
    article.destroy

    redirect to "/articles"
    
  end


end
