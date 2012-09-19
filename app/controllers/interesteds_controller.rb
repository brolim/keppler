require 'pp'
require 'gamefyvote'
require 'date'

class InterestedsController < ApplicationController
  def index
  	@interesteds = Interested.all
  end

  def create
    Interested.new(:email=>params[:interested][:email]).save! unless params[:interested][:email].nil?
    redirect_to root_path(:obrigado=>'k_rider')
  end

  def vote
  	@email = params[:email]

  	found = GamefyVote.where(:email=>params[:email])
  	if found.length == 0
  		@vote = GamefyVote.new(:email=>params[:email], 
  			:option=>findLessUsedOptions(), :date=>Time.new())
  		@vote.save
  	else
  		@vote = found[0]
  	end
  end

  def findLessUsedOptions
  	count = {1=>0, 2=>0, 3=>0}
  	GamefyVote.all.each do |c|
  		count[c.option[0]] += 1
  		count[c.option[1]] += 1
  	end
  	
  	first = 1
  	second = 2
  	[2,3].each do |v|
  		if count[v] < count[first]
  			second = first
  			first = v
  		elsif count[v] < count[second]
  			second = v
  		end
  	end

  	return [first,second]
  end

  def doVote
  	vote = nil
    pp params
  	GamefyVote.where(:email=>params[:email]).each do |v|
  		if v.vote == nil
  			vote = v
  		end
  	end

  	if vote == nil
  		vote = GamefyVote.new(:email=>params[:email], 
  			:option=>[0,0], :date=>Time.new())
  	end

  	vote.vote=params[:option].to_i
  	vote.save
  	render :json=>{}.to_json
  end
end