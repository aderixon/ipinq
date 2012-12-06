#!/usr/bin/ruby
# $Id$
#
# Script:	ipinq.rb
#
# Description:	Grep IP address text file for query strings
#
# Requires:	Sinatra, IPADDR file
#
# History:
#	20111205: Created - ajr
#

require 'rubygems'
require 'sinatra'
set :erb, :trim => '-'

IPADDR = '/var/www/html/ip_address.txt'	# ASCII file listing IP/hostnames
HOSTURI = "http://intranet/servers/"	# base URI for server pages

helpers do

  # enable template fragments (include files)
  # Usage: partial :foo
  def partial template
    erb template, :layout => false
  end

end

before do

  # background info
  @VERSION = "$Id$"
  @mtime = File.mtime(IPADDR).localtime

end

get '/' do
  @string = ""	# query string
  erb :index
end

#get '/grep/:string' do
get '/grep' do
  @string = params[:string]	# query
  comments = params[:comments]	# whether to include entry comments
  format = params[:format]	# output format (e.g. 'raw')
  @ans = Array.new

  # search file for the given string
  @ans = File.open(IPADDR).grep(/#{Regexp.quote(@string)}/i)

  if (! comments) then
    # strip comment from each line
    @ans = @ans.map {|x| x.sub(/#.*$/, '')}
  end

  if format != "raw" then
    # convert each server hostname into a (likely) hotlink
    # NOTE hardcoded server name format
    # if you hate ugly hacks, look away now
    @ans = @ans.map {|x| x.sub(/\b((web|mail|db).*\d{3})\b/, '<a href="' + HOSTURI + '/\1.html">\1</a>')}
    erb :grep	# format and display output
  else
    # raw text, no HTML formatting
    content_type 'text/plain'
    erb :grep_raw, :layout => false, :content_type => "text/plain"
  end
end
