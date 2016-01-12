# encoding: UTF-8

# DOC:
# We use Helper Methods for tree building,
# because it's faster than View Templates and Partials

# SECURITY note
# Prepare your data on server side for rendering
# or use h.html_escape(node.content)
# for escape potentially dangerous content

module AttachedFilesListHelper
  module Render
    class << self
      attr_accessor :h, :options

      def render_node(h, options)
        @h, @options = h, options
        @node = options[:node]

        "
          <li data-node-id='#{ @node.id }'>
            <div class='the-storages--item ptz--div-0 p15'>
              <div class='ptz--table'>
                <div class='ptz--tr'>
                  <div class='ptz--td pr20'>
                    #{ build_preview_pic }
                  </div>

                  <div class='ptz--td vat w100p'>
                    #{ url_input }
                    #{ show_link }
                    #{ show_size }
                  </div>

                  <div class='ptz--td pl20'>
                    #{ handler }
                    #{ delete }
                  </div>
                </div>
              </div>
            </div>

            #{ children }
          </li>
        "
      end

      def current_host
        h.request.protocol + h.request.host_with_port
      end

      def build_preview_pic
        if @node.is_image?
          src = @node.url(:preview)
          url = @node.url(:base)

          "<a href='#{ url }' target='_blank' class='the-storages--preview-pic'>
            <img src='#{ src }'>
          </a>"
        else
          ext = @node.file_ext
          url = @node.url

          "<a href='#{ url }'>
            <div class='the-storages--file-ext the-storages--file-ext-#{ ext }'></div>
          </a>"
        end
      end

      def url_input
        opts = {nocache: false, timestamp: false}
        url = @node.is_image? ? @node.url(:base, opts) : @node.url(:original, opts)
        "<div class='table w100p mb10'>
          <div class='row'>
            <div class='cell fs15 pr10 vam'>
              URL:
            </div>
            <div class='cell w100p'>
              <input class='ptz--input ptz--size-13 w100p' type='text' value='#{ current_host + url }'>
            </div>
          </div>
        </div>"
      end

      def show_link
        node = options[:node]
        ns   = options[:namespace]
        title_field = options[:title]
        title = node.send(title_field)
        url = @node.is_image? ? @node.url(:base) : @node.url
        "<div class='fs14 mb10'>#{ h.link_to(title, url) }</div>"
      end

      def show_size
        "<div class='fs12'>#{ @node.mb_size }</div>"
      end

      def handler
        "<div class='the-storages--handler mb20'>
          <i class='fa fa-arrows fs16'></i>
        </div>"
      end

      def delete
        "<div class='the-storages--delete tac'>
          #{ h.link_to '', @node, class: 'fa fa-trash-o fs14 the-storages--delete-attachment', method: :delete, data: { remote: true, confirm: 'Вы действительно хотите удалить этот файл?' } }
        </div>"
      end

      def children
        unless options[:children].blank?
          "<ol class='the-storages--nested-set'>#{ options[:children] }</ol>"
        end
      end

    end
  end
end
