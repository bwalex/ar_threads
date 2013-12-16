require 'bundler'
Bundler.require(:default)

require 'monitor'


class ConnPool
  self.extend(MonitorMixin)
  @@conns = 0
  @@tpool = ThreadSafe::Cache.new

  def self.checkout
    self.synchronize do
      @@conns += 1
    end

    @@tpool[Thread.current.object_id] = 1
  end

  def self.checkin
    self.synchronize do
      @@conns -= 1
      self.verify
    end

    @@tpool.delete Thread.current.object_id
  end

  def self.verify
    fail "negative conns!" if @@conns < 0
    fail "nil conn" if @@tpool[Thread.current.object_id].nil?
    fail "no connections" unless @@tpool[Thread.current.object_id] > 0
  end

  def self.report
    puts "Conn count: #{@@conns}"
  end
end
