require 'spec_helper'

describe DummyController do
  render_views
  context 'show the pay button' do
    before { get :index }
    it { should respond_with :success }
    it { should render_template :index }
    it 'should contain the form' do
      response.body.should have_xpath './/form[@action="https://secure.payza.com/checkout"]'
    end
    it 'should contain ap_purchasetype' do
      response.body.should have_xpath './/input[@name="ap_purchasetype"]'
    end
    it 'should contain ap_merchant' do
      response.body.should have_xpath './/input[@name="ap_merchant"]'
    end
    it 'should contain ap_itemname' do
      response.body.should have_xpath './/input[@name="ap_itemname"]'
    end
    it 'should contain ap_currency' do
      response.body.should have_xpath './/input[@name="ap_currency"]'
    end
    it 'should contain ap_amount' do
      response.body.should have_xpath './/input[@name="ap_amount"]'
    end
    it 'should contain ap_description' do
      response.body.should have_xpath './/input[@name="ap_description"]'
    end
    it 'should contain ap_returnurl' do
      response.body.should have_xpath './/input[@name="ap_returnurl"]'
    end
    it 'should contain ap_cancelurl' do
      response.body.should have_xpath './/input[@name="ap_cancelurl"]'
    end
    it 'should contain apc_1' do
      response.body.should have_xpath './/input[@name="apc_1"]'
    end
    it 'should contain ap_image' do
      response.body.should have_xpath './/input[@name="ap_image"]'
    end
  end
end