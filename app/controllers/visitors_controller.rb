class VisitorsController < ApplicationController
  before_action :tenant_data
  decorates_assigned :page

  def index
  end

  private

  def tenant_data
    if public?
      @page = Page.friendly.find_by(name: 'home')
      @tenants = {}
      Tenant.where(enabled: true).each do |tenant|
        continent = tenant.settings(:current).value[:continent]
        (@tenants[continent] ||= []) << tenant
      end
      @tenants = @tenants.sort { |a, b| a.first <=> b.first }
      respond_to do |type|
        type.html { render template: 'visitors/public/index.html.haml', layout: 'public/application' }
      end
    end
  end

  def public?
    Apartment::Tenant.current == 'public'
  end
end
