# encoding: utf-8
require 'spec_helper'
require 'date'

describe InterestedsController do

	describe 'GET vote' do

		it 'sorts options 1 and 2 for an empty database' do
			GamefyVote.all.should == []
			get :vote, :email=>'test@server.com'
			GamefyVote.all.length.should == 1
			vote = GamefyVote.all[0]
			vote.email.should == 'test@server.com'
			vote.option.should == [1,2]
			vote.vote.should == nil
			vote.date.should == Time.new(utc_offset="+00:00")
			assigns(:vote).should eq(vote)
		end

		it 'sorts options 2 and 3 for when 3 has no entry before' do
			Factory.create(:gamefyvote, :option=>[1,2])
			get :vote, :email=>'test@server.com'
			GamefyVote.all.length.should == 2
			vote = GamefyVote.all[1]
			vote.email.should == 'test@server.com'
			vote.option.should == [3,1]
			vote.vote.should == nil
			vote.date.should == Time.new(utc_offset="+00:00")
			assigns(:vote).should eq(vote)
		end

		it 'sorts the less voted one' do
			Factory.create(:gamefyvote, :option=>[3,3])
			Factory.create(:gamefyvote, :option=>[2,3])
			Factory.create(:gamefyvote, :option=>[1,1])
			get :vote, :email=>'test@server.com'
			size = GamefyVote.all.length
			vote = GamefyVote.all[size-1]
			vote.option.should == [2,1]
			assigns(:vote).should eq(vote)
		end

		it 'sorts the less voted one' do
			Factory.create(:gamefyvote, :option=>[1,2])
			Factory.create(:gamefyvote, :option=>[3,1])
			get :vote, :email=>'test@server.com'
			size = GamefyVote.all.length
			vote = GamefyVote.all[size-1]
			vote.option.should == [2,3]
			assigns(:vote).should eq(vote)
		end

		it 'returns the same option as before' do
			Factory.create(:gamefyvote, :email=>'test@server.com', :option=>[3,1])
			get :vote, :email=>'test@server.com'
			size = GamefyVote.all.length
			vote = GamefyVote.all[size-1]
			vote.option.should == [3,1]
			assigns(:vote).should eq(vote)
		end

		it 'doesnt know what to do when theres no mail informed'

	end


	describe 'PUT vote' do
		it 'saves on the last vote of the person' do
			Factory.create(:gamefyvote, :option=>[3,1])
			vote = Factory.create(:gamefyvote, :email=>'test@server.com')
			
			put :doVote, :option=>1, :email=>'test@server.com'
			size = GamefyVote.all.length
			size.should == 2
			vote.reload
			vote.vote.should == 1
		end

		it 'saves on the last non voted vote of the person' do
			vote = Factory.create(:gamefyvote, :email=>'test@server.com', 
							:vote=>1)
			realvote = Factory.create(:gamefyvote, :email=>'test@server.com')
			
			put :doVote, :option=>2, :email=>'test@server.com'
			size = GamefyVote.all.length
			size.should == 2
			vote.reload
			vote.vote.should == 1
			realvote.reload
			realvote.vote.should == 2
		end

		it 'saves on a new vote for the person if none is free' do
			vote = Factory.create(:gamefyvote, :email=>'test@server.com', 
							:vote=>1)
			
			put :doVote, :option=>2, :email=>'test@server.com'
			size = GamefyVote.all.length
			size.should == 2
			vote.reload
			vote.vote.should == 1
			realvote.reload
			realvote.vote.should == 2
		end

		it 'doesnt know what to do when theres no mail informed'
	end

end

