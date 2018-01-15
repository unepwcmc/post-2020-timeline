require 'csv'

namespace :import do
  desc "import CSV data into database"
  task :events, [:csv_file] => [:environment] do |t, args|

    import_csv_file(args.csv_file)
  end

  def import_csv_file file
    csv = File.open(file, encoding: "utf-8")
    csv_headers = File.readlines(csv).first.split(",")

    event_hash = {
      title: csv_headers[0],
      start_date: csv_headers[1],
      end_date: csv_headers[2],
      location: csv_headers[3],
      organisers: csv_headers[4],
      summary: csv_headers[5],
      relevance: csv_headers[6],
      outputs: csv_headers[7],
      category: csv_headers[8],
      cbd_relation: csv_headers[10].chomp
    }

    CSV.parse(csv, headers: true, encoding: "utf-8") do |row|
      csv_event_row = row.to_hash
      event_row_hash = {}

      event_hash.keys.each do |key|
        next if key == :organisers
        if [:outputs, :summary, :category, :cbd_relation].include? key
          event_row_hash[key] = csv_event_row[event_hash[key]]&.strip || "Empty"
        elsif [:start_date, :end_date].include? key
          event_row_hash[key] = csv_event_row[event_hash[key]]&.strip || nil
        else
          event_row_hash[key] = csv_event_row[event_hash[key]]&.strip
        end
      end

      current_event_title = csv_event_row[event_hash[:title]]

      if Event.exists?(title: current_event_title)
        event = Event.find_by(title: current_event_title)
        unless event.update_attributes(event_row_hash)
          Rails.logger.info "Cannot update! #{event.title}"
        end
      else
        event = Event.new(event_row_hash)
        unless event.save!
          Rails.logger.info "Cannot import! #{event.title}"
        end
      end

      list_of_organisers = csv_event_row[event_hash[:organisers]]&.strip
      unless list_of_organisers.nil?
        list_of_organisers = list_of_organisers.split(",")
        list_of_organisers.each do |organiser|
          organiser = organiser&.strip
          new_organiser = Organiser.find_or_create_by(name: organiser)
          unless event.organisers.exists?(new_organiser.id)
            event.organisers << new_organiser
          end
        end
      end

    end

    csv.close

    Rails.logger.info "Imported Events, total records: #{Event.count}"

  end

end
