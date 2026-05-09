class ApplicationController
  attr_reader :req, :res
  
  def initialize(req, res)
    @req = req
    @res = res
  end
  
  def params
    @req.params
  end
  
  def session
    @req.env['eks_cent.session'] ||= {}
  end
  
  def render(template, **locals)
    # Pass controller instance variables to the view
    instance_variables.each do |var|
      locals[var.to_s.delete('@').to_sym] ||= instance_variable_get(var)
    end
    @res.render(template, **locals)
  end
  
  def redirect_to(path)
    @res.status = 302
    @res.headers['Location'] = path
  end
  
  # Validation Helper
  def validate!(required_params)
    missing = required_params.select { |p| params[p.to_s].nil? || params[p.to_s].empty? }
    unless missing.empty?
      @res.status = 400
      render 'error', message: "Missing required parameters: #{missing.join(', ')}"
      throw(:halt)
    end
  end
  
  # CSRF Helper for views
  def csrf_token
    @req.env['eks_cent.csrf_token']
  end
end
