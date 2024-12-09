async function loadMap() {
  try {
      // API 키 가져오기
      const response = await fetch('http://localhost:3000/api/google-maps-key');
      if (!response.ok) {
          throw new Error('API 키를 가져오는데 실패했습니다');
      }
      const data = await response.json();
      const apiKey = data.apiKey;

      // Google Maps API 로드
      const script = document.createElement('script');
      script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap`;
      script.async = true;
      script.defer = true;
      script.onerror = () => {
          console.error('Google Maps API 로드 실패');
          alert('지도를 로드하는데 실패했습니다. 잠시 후 다시 시도해주세요.');
      };
      document.head.appendChild(script);
  } catch (error) {
      console.error('Error:', error);
      alert('서버 연결에 실패했습니다. 잠시 후 다시 시도해주세요.');
  }
}

// Google Maps 초기화 함수
function initMap() {
  try {
      const valencia = { lat: 39.4699, lng: -0.3763 };
      const mapOptions = {
          center: valencia,
          zoom: 13,
          mapTypeControl: true,
          streetViewControl: true,
          fullscreenControl: true
      };

      const map = new google.maps.Map(
          document.getElementById("googleMap"),
          mapOptions
      );

      // 발렌시아 중심에 마커 추가
      new google.maps.Marker({
          position: valencia,
          map: map,
          title: "Valencia City Center"
      });
  } catch (error) {
      console.error('Map initialization error:', error);
      alert('지도 초기화에 실패했습니다.');
  }
}

// 페이지 로드시 지도 로드 시작
document.addEventListener('DOMContentLoaded', loadMap);