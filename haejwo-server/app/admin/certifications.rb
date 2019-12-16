ActiveAdmin.register User, as: 'Certifacation' do
  menu parent: '인증관리', label: '사용자인증관리'
  actions :all, except: [:new, :create]

  controller do
    def scoped_collection
      User.waiting
    end
  end

  scope -> { '전체' }, :all

  filter :name_cont, label: '이름으로 검색'
  filter :email_cont, label: '이메일로 검색'
  filter :phone_cont, label: '전화번호로 검색'

  batch_action '인증상태 변경', form: {
    state: User.enum_selectors(:certification_state)
  } do |ids, inputs|
    users = User.find(ids)
    users.each do |user|
      user.update!(certification_state: inputs[:state])
    end
    flash[:notice] = "해당 사용자(들)의 인증이 성공적으로 처리 되었습니다."
    redirect_back(fallback_location: collection_path)
  end

  index do
    selectable_column
    id_column
    column :image do |user|
      image_tag(user.thumbnail_url ,class: 'admin-index-image')
    end
    column :image do |user|
      image_tag(user.student_card_image_url, class: 'admin-index-image')
    end
    column :email
    column :sign_in_count
    column :name
    column :phone

    column :created_at
    actions
  end

  show do
    attributes_table do
      row :image do |user|
        image_tag(user.image_url ,class: "admin-show-image")
      end
      row :email
      row :name
      row :phone

      row :created_at
      row :updated_at
      row :created_at
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :encrypted_password
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :gender
      f.input :status
    end
  end
end
