module ApplicationHelper
	def title(page_title)
		content_for(:title) { page_title }
	end

	def markdown(text)
		options = { :autolink => true, :hard_wrap => true, :filter_html => true, :no_intra_emphasis => true, :fenced_code_blocks => true }
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
		markdown.render(text).html_safe
	end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_add_short_answer(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    

    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      
      render( "short_answer_fields", :f => builder)
    end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  def link_to_add_hidden_answers(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    

    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      
      render( "answer_fields_hidden", :f => builder)
    end
      
  end

  def sortable(column, scope = nil, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column)? "sort_current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc")? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :scope => scope,:page => nil), {:class => css_class}
  end
end
