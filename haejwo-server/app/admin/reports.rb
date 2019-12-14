ActiveAdmin.register Report do
  menu parent: '신고관리', label: '사용자신고관리'
  actions :index, :destroy

  batch_action '블랙리스트 설정', form: {
    blacklist: [['블랙리스트 추가', false]]
  } do |ids, inputs|
    reports = Report.find(ids)
    reports.each do |report|
      report.user.update(blacklist: inputs[:blacklist])
    end
    flash[:notice] = "해당 신고 처리가 완료되었습니다."
    redirect_back(fallback_location: collection_path)
  end

  index do
    selectable_column
    id_column
    column :user
    column :event
    column :content
    column :created_at
    actions
  end
end
