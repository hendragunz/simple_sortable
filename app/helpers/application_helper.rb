module ApplicationHelper
  # to include javascsript file to page
  def javascript(*args)
    content_for(:javascript) { javascript_include_tag(*args) }
  end

  # to call js function on document.ready
  def call_js_init(something_js)
    content_for :javascript do
      "<script type='text/javascript'>
          $(document).ready(function(){
            #{something_js}
          });
      </script>".html_safe
    end
  end
end
