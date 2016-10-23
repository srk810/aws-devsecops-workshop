#!/usr/bin/env ruby

require 'serverspec'
require_relative '../spec_helper'

describe 'Nginx Installation' do
  # Nginx downloaded in correct location
  describe file('/opt/nginx/nginx-1.11.5') do
    it { should exist }
    it { should be_directory }
  end

  # Correct version of nginx
  describe command('/usr/local/sbin/nginx -v') do
    its(:stderr) { should match(%r{nginx version: nginx/1.11.5}) }
    its(:exit_status) { should eq 0 }
  end

  # Nginx should be running
  describe process('nginx') do
    it { should be_running }
  end

  # Listening on the correct port
  describe port(80) do
    it { should be_listening }
  end
end
