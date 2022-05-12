# GIST HELPER
![image](https://user-images.githubusercontent.com/68385607/168115306-b70e2a8b-cc7f-4978-bcea-3d83c6dddeb7.png)

카카오톡 채널 링크: [https://pf.kakao.com/_dxcBxlb](https://pf.kakao.com/_dxcBxlb)

컨트롤러 소스코드 링크: [https://github.com/gist-helper/meals_controller_hyoinjeong](https://github.com/gist-helper/meals_controller_hyoinjeong)
데이터 처리 소스코드 링크: https://github.com/gist-helper/meals_data-parsing_hyoinjeong

컴퓨터공학도로서 다양한 개발 분야를 접하고자 작년 10월, 교내 앱 개발 스터디에 참여한 적이 있습니다. 스터디에서 1달 가량 웹 앱의 기초를 잡기 위해 Rails 공부를 마치고 실제 프로젝트를 통하여 공부의 깊이를 더하고자 ‘교내 식당 식단 알림 앱’을 기획하였습니다. 안드로이드 2명, 서버 2명으로 이루어진 팀에서 저는 서버 분야를 맡았습니다. 데이터베이스 과목에서 배운 내용을 기반으로 ERD를 그리는 것부터 시작하였습니다.

기능 확장을 생각해서 날짜:장소:메뉴 관계를 각각 다대다 관계로 정의하는 설계 방안과 빠른 개발에 이점이 있는 한 테이블에 모든 정보를 담아버리는 설계 방안이 있었습니다. 교내 식당이 세군데가 있어 식단 엔티티가 많지 않다고 생각했고 lean하게 개발하고자 후자의 설계 방안을 채택하였습니다.이 과정에서 웹 앱을 개발할 때 설계가 중요하다는 것을 몸소 느낄 수 있었습니다.
그러던 중 Kotlin의 높은 진입장벽과 팀원의 개인적인 사정으로 인해 안드로이드 팀원들이 모두 하차하였습니다. 또한, 남은 백엔드 팀원도 연락이 끊겼습니다. 하지만 정말 교내에 필요한 앱이라고 생각했기에, 저 혼자서 개발을 이어나갔습니다. Ruby on Jets 라는 serverless framework를 기반으로 빠르게 출시하여 피드백을 받고자 하였고, 안드로이드 팀원의 부재를 카카오톡 챗봇 플랫폼으로 해결하고자 하였습니다.

Ruby on Jets를 통하여 AWS Lambda, EC2, EIP, RDS, Cloud Watch등 다양한 AWS 인프라 서비스를 쓰는 경험을 할 수 있었습니다. DB는 PostgreSQL과 MySQL 중 간단한 쿼리만 할 것을 생각하여 MySQL를 사용하였는데, 그 과정에서 배열 데이터를 저장할 때 json type으로 치환해서 저장하고, encoding에 따라 한국어 지원이 안된다는 점 등 MySQL에 대한 여러 지식을 얻을 수 있었습니다. 마지막으로 카카오톡 챗봇 플랫폼에 개발한 AWS Lambda API를 연결하면서 전체적인 웹 서비스 구조에 대하여 이해할 수 있었습니다.

현재 매주 엑셀 파일로 영양사 선생님들께 식단표 엑셀 파일을 받은 후, python script를 통해 이를 json 형태의 데이터로 바꾸어 POST ACTION을 통해 AWS RDS DB에 저장하고 있습니다.
그 뒤 사용자 요청이 있을 때마다 Controller에 대응되는 Lambda function들이 DB에서 request에 부합하는 정보를 얻어와 식단 정보를 카카오톡 클라이언트로 보내는 시스템입니다.

그렇게 런칭한 GIST Helper 채널을 통해 현재 100명 가량이 카카오톡으로 식단을 받아보고 있습니다. 서비스의 이용자가 많아질수록, 책임감과 뿌듯함이 커져나갑니다. 서비스를 제공한다는 것이 얼마나 가치있고 재미있는 일인지 느낄 수 있었습니다.
