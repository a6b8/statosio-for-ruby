# frozen_string_literal: true
require_relative 'boilerplate'
require_relative "statosio/version"
require 'puppeteer'

module Statosio
  class Error < StandardError; end


  class Generate < Boilerplate
    def svg( dataset: nil, x: nil, y: nil, options: nil, silent: false )
      valid = values_validation( dataset: dataset, x: x, y: y, options: options, allow_list: @options_allow_list, silent: silent )
      if valid
        values = {}
        values[:dataset] = dataset
        values[:x] = x
        values[:y] = y
        values[:options] = options
        render_svg( values )
      end
    end


    def get_options_allow_list
      @options_allow_list
    end


    def render_prepare( values )
      self.set_markers_value( values )
      self.set_boilerplate
      html = self.get_boilerplate
    end


    def render_svg( values )
      html = self.render_prepare( values )
      g = {}
      id = 'd3_statosio'
      g[:start] = '<div id="' + id + '">'
      g[:end] = '</div>'
    
      svg = Puppeteer.launch do | browser |
        page = browser.pages.last || browser.new_page
        page.set_content( html )
        html = page.evaluate( 'document.body.innerHTML' )
        tmp = html[ html.index( g[:start] ) + g[:start].length, html.length]
        tmp = tmp[ 0, tmp.index( g[:end] ) ]
      end
      return svg
    end

    
    def values_validation( dataset: nil, x: nil, y: nil, options: nil, allow_list: nil, silent: false )  
      def check_dataset( dataset, messages, errors )
        if !dataset.nil?
          if dataset.class.to_s == 'Array'
            if dataset[ 0 ].class.to_s == 'Hash' or dataset[ 0 ].class.to_s == 'ActiveSupport::HashWithIndifferentAccess'
              if dataset[ 0 ].keys.length > 1
                search = dataset[ 0 ].keys
                keys = dataset
                  .map { | a | a.keys }
                  .flatten
                  .to_set
                  .to_a
                if keys.eql? search
                else
                  errors.push( messages[:dataset][ 4 ])
                end
              else
                errors.push( messages[:dataset][ 3 ])
              end
            else
              errors.push( messages[:dataset][ 2 ] )
            end
          else
            errors.push( messages[:dataset][ 1 ] )
          end
        else
          errors.push( messages[:dataset][ 0 ] )
        end
        return errors
      end
    
    
      def check_x( x, messages, errors )
        if !x.nil?
          if x.class.to_s == 'String'
          else
            errors.push( messages[:x][ 1 ] )
          end
        else
          errors.push( messages[:x][ 0 ] )
        end
        return errors
      end
    
    
      def check_y( y, messages, errors )
        if !y.nil?
          if y.class.to_s == 'String' or y.class.to_s == 'Array'
          else
            errors.push( messages[:y][ 1 ] )
          end
        else
          errors.push( messages[:y][ 0 ] )
        end
        return errors
      end 
    
    
      def check_options( options, messages, allow_list, errors )
        def str_difference( a, b )
          a = a.to_s.downcase.split( '_' ).join( '' )
          b = b.to_s.downcase.split( '_' ).join( '' )
          longer = [ a.size, b.size ].max
          same = a
            .each_char
            .zip( b.each_char )
            .select { | a, b | a == b }
            .size
          ( longer - same ) / a.size.to_f
        end
    
    
        if !options.nil?
          if options.class.to_s == 'Hash'
            options.keys.each do | key |
              if allow_list.include?( key.to_s )
              else
                tmp = messages[:options][ 2 ][ 0 ]
                tmp = tmp.gsub( '<--key-->', key.to_s)
    
                nearest = allow_list
                  .map { | word | { score: str_difference( key, word ), word: word } }
                  .min_by { | item | item[:score] }
                tmp = tmp.gsub( '<--similar-->', nearest[:word] )
                errors.push( [ tmp, messages[:options][ 2 ][ 1 ] ] )
              end
            end
          else
            errors.push( messages[:options][ 1 ] )
          end
        else
          errors.push( messages[:options][ 0 ] )
        end
    
        return errors
      end
    
    
      def check_silent( silent, messages, errors )
        value = silent.class.to_s
        if value == 'FalseClass' or value == 'TrueClass'
        else
          errors.push( messages[:silent][ 0 ] )
        end
        return errors
      end
    
    
      messages = {
        dataset: [
          [ "dataset:\t is empty. Expect: \"Array\" [{},{}]", :d0 ],
          [ "dataset:\t is not class \"Array\"", :d1 ],
          [ "dataset:\t is not class \"Hash\"", :d2 ],
          [ "dataset:\t \"Hash\" has less then 2 keys", :d3 ],
          [ "dataset:\t have diffrent keys", :d4 ]
        ],
        x: [
          [ "x:\t\t is empty. Expect: \"String\"", :x0 ],
          [ "x:\t\t is not Class \"String\"", :x1 ]
        ],
        y: [
          [ "y:\t\t is empty. Expect: \"String\"", :y0 ],
          [ "y:\t\t is not Class \"String\"", :y1 ]
        ],
        options: [
          [ "options:\t is empty. Expect: \"Hash\"", :p0 ],
          [ "options:\t is not Class \"Hash\"", :p1 ],
          [ "options:\t key: \"<--key-->\" is not a valid parameter, did you mean: \"<--similar-->\"? For more Information visit: https://docs.statosio.com/options/<--similar-->", :p2 ]
        ],
        silent: [
          [ "silent:\t is not Class \"Hash\"", :s0 ]
        ]
      }
    
      errors = []
      errors = check_dataset( dataset, messages, errors )
      errors = check_y( y, messages, errors )
      errors = check_x( x, messages, errors )
      errors = check_options( options, messages, allow_list, errors )
      errors = check_silent( silent, messages, errors )
    
      if silent == false
        if errors.length != 0
          puts errors.length.to_s + ' Errors found: '
          errors.each { | error | puts( ' - ' + error[ 0 ] ) }
        end
      end
    
      return errors.length == 0
    end
  end
end
