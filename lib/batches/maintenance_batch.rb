class Batches::MaintenanceBatch
  def self.start
    # maintenance.ymlを生成する
    return if FileTest.exist?('config/tmp/maintenance.yml')
    data = { start_time: Time.current }
    YAML.dump(data, File.open('config/tmp/maintenance.yml', 'w'))
  end

  def self.end
    # maintenance.ymlを削除する
    return unless FileTest.exist?('config/tmp/maintenance.yml')
    File.delete('config/tmp/maintenance.yml')
  end
end

