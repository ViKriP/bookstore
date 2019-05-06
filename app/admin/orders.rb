ActiveAdmin.register Order do
    permit_params :user, :delivery, :discount, :state
    batch_action :destroy, false
    actions :index, :show, :update, :edit
  
    scope :in_progress, group: :state
    scope :in_queue, group: :state
    scope :in_delivery, group: :state
    scope :delivered, group: :state
    scope :canceled, group: :state
  
    index do
      id_column
      column I18n.t('admin.date'), :created_at
      column :state
      actions defaults: false do |order|
        item I18n.t('admin.show'), admin_order_path(order)
      end
    end
  
    show do
      columns do
        column do
          attributes_table do
            default_attribute_table_rows.each do |field|
              row field
            end
          end
        end
  
        column do
          panel I18n.t('admin.order_items') do
            ul style: 'margin: 0' do
              order.order_items.each do |item|
                li link_to("#{item.book.title} (#{item.quantity})", admin_order_item_path(item))
              end
            end
          end
        end
      end
  
      active_admin_comments
    end
  
    form do |f|
      f.inputs do
        f.input :state, as: :select, collection: %i[in_delivery canceled] if order.state == 'in_queue'
        f.input :state, as: :select, collection: %i[delivered canceled] if order.state == 'in_delivery'
      end
      f.actions
    end
  end