ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
        br
        div "Authors count: #{Author.count}"
        div "Categories count: #{Category.count}"
        div "Books count: #{Book.count}"
        div "Reviews count: #{Review.count}"
        br
        div "Users count: #{User.count}"
        div "Orders count: #{Order.count}"
        div "Delivery type count: #{Delivery.count}"
      end
    end
  end
end
