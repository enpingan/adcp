class Ticket < ActiveRecord::Base
  has_many :comments
  belongs_to :devices

  self.table_name = "Tickets"

  def self.search(filter_item)

    if !filter_item.nil? && filter_item != ""
      tmp = filter_item
      tickets = Ticket.where("id LIKE ? OR subject LIKE ? OR ticket_group LIKE ? OR owner LIKE ? OR device LIKE ? OR last_replied LIKE ?", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%", "%#{tmp}%")
    else
      tickets = Ticket.all
    end
    # fresh_when tickets

    return tickets
  end

  def self.delete_ticket(ticket_id)
    if !ticket_id.nil?
      tt = Ticket.find_by_id(ticket_id)
      comments = Comment.where(:ticket_id=>ticket_id)
      # fresh_when comments

      if !tt.nil?
        tt.delete

        if !comments.blank?
          comments.delete_all
        end

        return true
      else
        return false
      end
    end

    return false
  end

  def self.add_comment(params, username)
    # leave comment
    cmp = params
    
    if !cmp.nil?
      if !cmp["comment"].blank?
        comment = Comment.new
        comment.comment = cmp["comment"]
        comment.ticket_id = cmp["tid"]["tid"]
        comment.ticket_owner = username

        comment.save

        # ticket = Ticket.where(:id=>comment.ticket_id)
        ticket = Ticket.find_by_id(comment.ticket_id)
        ticket.is_read = true
        ticket.last_replied = cmp["lre"]["lre"]
        ticket.save
      end
    end
  end

  def self.delete_comment(params)
    if !params.blank?
      dval = Comment.find_by_id(params[:comment_id])
      if !dval.nil?
        dval.delete
      end
    end
  end

  def self.ticket_sortable(column, direction)
    case column
    when "Ticket ID"
      col = "id "
    when "Group"
      col = "ticket_group "
    when "Subject"
      col = "subject "
    when "Owner"
      col = "owner "
    when "Last replied"
      col = "last_replied "
    when "Device"
      col = "device "
    when "Updated"
      col = "updated_at "
    else
      col = " "
    end

    return col + direction
  end

  def self.to_thdindex(sort_item)
    case sort_item
    when "Ticket ID"
      col = 0
    when "Group"
      col = 1
    when "Subject"
      col = 2
    when "Owner"
      col = 3
    when "Last replied"
      col = 4
    when "Device"
      col = 5
    when "Updated"
      col = 6
    else
      col = 7
    end

    return col
  end


end
