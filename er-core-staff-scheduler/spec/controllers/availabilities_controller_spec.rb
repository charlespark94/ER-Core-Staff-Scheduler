require 'spec_helper'

describe AvailabilitiesController do
	it 'should rendering index' do
		get :index, {:id => 1}
		response.should render_template('index')
	end

	context "when param is yes" do
		let(:params) {{:"2" => yes}}
		it 'should update atrribute when yes' do
			get :index, {:params => {:"1" => "yes"}}
	 		{:possible_users => nil, :users=>1}
		end
	end

	it 'should update atrribute when maybe' do
		get :index, {:params => {:"1" => "maybe"}}
	end

	it 'should update atrribute when no' do
		get :index, {:params => {:"1" => "no"}}
	end
end
