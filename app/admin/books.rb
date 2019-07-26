ActiveAdmin.register Book do
  permit_params :title, :price, :quantity, :year, :description, :materials,
                :height, :width, :depth, author_ids: [], category_ids: [], images: []

  index do
    selectable_column

    id_column
    column :title
    column :price
    column :quantity
    column :description
    column :year
    column :materials
    column :height
    column :width
    column :depth
    column :images

    actions
  end

  filter :title
  filter :price
  filter :quantity
  filter :description
  filter :year
  filter :materials
  filter :height
  filter :width
  filter :depth

  form do |f|
    f.inputs do
      f.input :title
      f.input :price
      f.input :quantity
      f.input :year
      f.input :description
      f.input :materials
      f.input :height
      f.input :width
      f.input :depth
      f.input :categories, as: :select, collection: Category.pluck(:title, :id)
      f.input :authors, as: :select, collection: Author.pluck(:last_name, :id)
      f.file_field :images, multiple: true
    end
    f.actions
  end
end
