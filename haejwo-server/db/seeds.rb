admin_user_email = 'admin@example.com'
admin_user_password = 'password'
if AdminUser.find_by(email: admin_user_email).nil?
  AdminUser.create!(email: admin_user_email, password: admin_user_password, password_confirmation: admin_user_password)
end
Building.find_or_create_by!(
  name: '본관',
  lat: 37.558500,
  lng: 126.999517
)
Building.find_or_create_by!(
  name: '신공학관',
  lat: 37.558092,
  lng: 126.998207
)
Building.find_or_create_by!(
  name: '명진관',
  lat: 37.557663,
  lng: 126.999963
)
Building.find_or_create_by!(
  name: '법학관',
  lat: 37.558001,
  lng: 127.000963
)
Building.find_or_create_by!(
  name: '과학관',
  lat: 37.557323,
  lng: 126.999861
)
Building.find_or_create_by!(
  name: '원흥관',
  lat: 37.558520,
  lng: 126.998920
)
Building.find_or_create_by!(
  name: '혜화관',
  lat: 37.557661,
  lng: 127.001903
)
Building.find_or_create_by!(
  name: '학림관',
  lat: 37.560242,
  lng: 126.999809
)
Building.find_or_create_by!(
  name: '학생회관',
  lat: 37.560067,
  lng: 126.998394
)
Building.find_or_create_by!(
  name: '경영관',
  lat: 37.556946,
  lng: 127.002867
)
Building.find_or_create_by!(
  name: '사회과학관',
  lat: 37.557545,
  lng: 127.002585
)
Building.find_or_create_by!(
  name: '문화관',
  lat: 37.557689,
  lng: 127.003050
)
Building.find_or_create_by!(
  name: '학술관',
  lat: 37.557997,
  lng: 127.003552
)
Building.find_or_create_by!(
  name: '다향관',
  lat: 37.558707,
  lng: 127.000198
)
Building.find_or_create_by!(
  name: '금광관',
  lat: 37.559520,
  lng: 127.000168
)
Building.find_or_create_by!(
  name: '계산관A',
  lat: 37.560447,
  lng: 126.999231
)
Building.find_or_create_by!(
  name: '계산관B',
  lat: 37.560126,
  lng: 126.998981
)
Building.find_or_create_by!(
  name: '정보문화관',
  lat: 37.559604,
  lng: 126.998610
)
Building.find_or_create_by!(
  name: '팔정도',
  lat: 37.558190,
  lng: 127.000168
)
Building.find_or_create_by!(
  name: '중앙도서관',
  lat: 37.557874,
  lng: 126.999228
)
Building.find_or_create_by!(
  name: '정각원',
  lat: 37.557428,
  lng: 127.001177
)
Building.find_or_create_by!(
  name: '백년비',
  lat: 37.557236,
  lng: 127.000728
)
Building.find_or_create_by!(
  name: '상록원',
  lat: 37.556970,
  lng: 126.999681
)
Building.find_or_create_by!(
  name: '만해광장',
  lat: 37.559667,
  lng: 126.999384
)
Building.find_or_create_by!(
  name: '대운동장',
  lat: 37.556660,
  lng: 127.000698
)
Building.find_or_create_by!(
  name: '체육관',
  lat: 37.559788,
  lng: 127.000280
)
Building.find_or_create_by!(
  name: '남산학사',
  lat: 37.558399,
  lng: 126.998117
)
Building.find_or_create_by!(
  name: '혜화별관',
  lat: 37.557408,
  lng: 127.001442
)
Building.find_or_create_by!(
  name: '전산원',
  lat: 37.560122,
  lng: 127.000490
)
Building.find_or_create_by!(
  name: '원흥별관',
  lat: 37.558577,
  lng: 126.998599
)
Building.find_or_create_by!(
  name: '가온누리',
  lat: 37.558375,
  lng: 126.999196
)
Building.find_or_create_by!(
  name: '가든쿡',
  lat: 37.558286,
  lng: 127.003571
)
Building.find_or_create_by!(
  name: '정문',
  lat: 37.556633,
  lng: 127.002301
)
Building.find_or_create_by!(
  name: '혜와문(중문)',
  lat: 37.558433,
  lng: 127.003408
)
Building.find_or_create_by!(
  name: '후문',
  lat: 37.560439,
  lng: 126.998782
)
