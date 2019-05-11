ActiveAdmin.register Book do
  permit_params :title, :price, :quantity, :year, :description, :materials,
                :height, :width, :depth, author_ids: [], category_ids: [], images: []

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
      f.input :categories
      f.input :authors, as: :select, collection: Author.pluck(:last_name, :id)
      f.file_field :images, multiple: true
    end
    f.actions
  end
end
