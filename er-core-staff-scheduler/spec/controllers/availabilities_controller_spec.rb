require 'spec_helper'

describe AvailabilitiesController do
	it 'should rendering index' do
		get :index, nil, {:id => 1}
		response.should render_template('index')
	end

	it 'should update atrribute when yes' do
		get :index, {:params => {:id => "yes"}}
		response.should render_template('index')
	end

	it 'should update atrribute when maybe' do
		get :index, {:params => {:id => "maybe"}}
		response.should render_template('index')
	end

	it 'should update atrribute when yes' do
		get :index, {:params => {:id => "no"}}
		response.should render_template('index')
	end
end
