require 'csv'

namespace :import do
  desc "import CSV data into database"
  task :events, [:csv_file] => [:environment] do |t, args|

    import_csv_file(args.csv_file)
  end

  def logger
    @logger ||= Logger.new("#{Rails.root}/log/import.log")
  end

  def import_csv_file file
    csv = File.open(file, encoding: "utf-8")
    csv_headers = File.readlines(csv).first.split(",")

    event_hash = {
      title: csv_headers[0],
      start_date: csv_headers[1],
      end_date: csv_headers[2],
      is_provisional_date: csv_headers[3],
      location: csv_headers[4],
      organisers: csv_headers[5],
      summary: csv_headers[6],
      relevance: csv_headers[7],
      outputs: csv_headers[8],
      categories: csv_headers[9],
      cbd_relation: csv_headers[10].chomp
    }

    CSV.parse(csv, headers: true, encoding: "utf-8") do |row|
      csv_event_row = row.to_hash
      event_row_hash = {}
      skip_row = false

      event_hash.keys.each do |key|
        next if key == :organisers || key == :categories
        if [:outputs, :summary, :category, :cbd_relation, :relevance].include? key
          event_row_hash[key] = csv_event_row[event_hash[key]]&.strip&.gsub(/\u00a0/, " ") || ""
          event_row_hash[key] = (key == :cbd_relation && event_row_hash[key] == "") ? "N/A" : event_row_hash[key]
        elsif [:start_date, :end_date].include? key
          date = Date.parse(csv_event_row[event_hash[key]]&.strip) rescue nil
          (skip_row = true) && break unless date
          event_row_hash[key] = date
        elsif key == :is_provisional_date
          event_row_hash[key] = csv_event_row[event_hash[key]].present?
        else
          event_row_hash[key] = csv_event_row[event_hash[key]]&.strip
        end
      end

      error_message = "Invalid date for #{event_row_hash[:title]}. Skipping..."
      logger.info(error_message) && next if skip_row

      current_event_title = event_row_hash[:title]

      if Event.exists?(title: current_event_title)
        logger.info "Event already exists #{current_event_title}"
        event = Event.find_by(title: current_event_title)
        unless event.update_attributes(event_row_hash)
          logger.info "Cannot update! #{event.title}"
        end
      else
        logger.info "Processing #{current_event_title}..."
        event = Event.new(event_row_hash)
        unless event.save!
          logger.info "Cannot import! #{event.title}"
        end
      end

      fields = ["categories", "organisers"]

      fields.each do |field|
        list_of_children = csv_event_row[event_hash[field.to_sym]]&.strip
        next if list_of_children.nil?
        list_of_children = list_of_children.split(",")
        list_of_children.each do |child_name|
          child_name = child_name&.strip
          new_child = field.camelize.singularize.constantize.find_or_create_by(name: child_name)
          unless event.send(field.to_sym).exists?(new_child.id)
            event.send(field.to_sym) << new_child
          end
        end
      end

    end

    csv.close

    logger.info "Imported Events, total records: #{Event.count}"

  end

end
