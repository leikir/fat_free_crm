# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
ActionController::Renderers.add :csv do |objects, options|
  filename = options[:filename] || controller_name || 'data'
  headers["Content-Type"] = "text/csv"
  headers["Content-disposition"] = "attachment; filename=\"#{filename}.csv\""
  headers['X-Accel-Buffering'] = 'no'
  headers["Cache-Control"] ||= "no-cache"
  headers.delete("Content-Length")
  self.response_body = FatFreeCRM::ExportCSV.from_array(objects)
end
