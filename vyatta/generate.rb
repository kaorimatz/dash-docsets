require 'nokogiri'
require 'pathname'
require 'sqlite3'

docset_doc = Pathname.new(ARGV[0])
docset_db = Pathname.new(ARGV[1])

entries = []
Pathname.glob("#{docset_doc}/**/*.html") do |html_path|
  Nokogiri.parse(html_path.read) do |doc|
    if heading = doc.xpath("//div[@class='CmdHeading']").first
      entries << {
        name: heading.content,
        type: 'Command',
        path: html_path.relative_path_from(docset_doc).to_s
      }
    end
  end
end

SQLite3::Database.new(docset_db.to_s) do |db|
  db.execute 'DROP TABLE IF EXISTS searchIndex'
  db.execute 'CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT)'
  db.execute 'CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path)'
  db.prepare 'INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES (:name, :type, :path)' do |stmt|
    entries.each do |entry|
      stmt.execute entry
    end
  end
end
