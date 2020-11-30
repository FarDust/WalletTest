require 'digest/md5'
module DashboardHelper

  def fancyUUID(identifier)
    Digest::MD5.hexdigest(identifier.to_s.rjust(64, '0'))
  end

end
