let ACCESS_HISTORY_CTX;
let ACCESS_HISTORY_CHART;
let ACCESS_HISTORY_DAY_LONGS = [7, 14, 30];
let isFetching = false;

window.onload = () => {

    Chart.defaults.global.defaultFontFamily = "NotoSansKR";
    Chart.defaults.global.defaultFontColor = "#272C34";
    Chart.defaults.global.defaultFontSize = 12;

    ACCESS_HISTORY_CTX = document.getElementById("ACCESS-CHART");

    initTopBarAdminEvents();
    initAdminIndex();

};

const initAdminIndex = () => {

    createAccessChart();

};

const createAccessChart = async () => {

    const initialData = await requestAccessHistory(7);

    ACCESS_HISTORY_CHART = new Chart(ACCESS_HISTORY_CTX, {
        type: "line",
        data: {
            labels: initialData.labels,
            datasets: [{
                label: '서비스 접근',
                backgroundColor: '#FAFAFA',
                borderColor: '#7C4DFF',
                borderDash: [10, 10],
                pointBackgroundColor: "#FFFFFF",
                pointBorderColor: "#272C34",
                pointBorderWidth: "2",
                data: initialData.data
            }]
        },
        options: {
            maintainAspectRatio: false,
            scales: {
                xAxes: [{
                    display: true,
                    gridLines: {
                        display: false
                    }
                }],
                yAxes: [{
                    display: false,
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        beginAtZero: true
                    }
                }]
            },
            legend: {
                display: false
            },
            onClick() {
                ACCESS_HISTORY_DAY_LONGS.push(ACCESS_HISTORY_DAY_LONGS.shift());
                updateAccessChart(ACCESS_HISTORY_DAY_LONGS[0]);
            }
        }
    });

};

const updateAccessChart = async (duration) => {
    /*
     * 1. NOW() 부터 파라미터 값 전까지의 데이터를 반환
     * 2. 차트의 데이터로 할당
     * 3. 차트 인스턴스 Update()
     */
    const accessHistory = await requestAccessHistory(duration);

    ACCESS_HISTORY_CHART.data.labels = accessHistory.labels;
    ACCESS_HISTORY_CHART.data.datasets[0].data = accessHistory.data;

    ACCESS_HISTORY_CHART.update();

};

const requestAccessHistory = async (duration) => {

    if (!isFetching) {

        isFetching = true;
        const response = await fetch("/eiki/admin/access/history/" + duration, {method: "GET"})
        let responseBody = await response.json();
        isFetching = false;

        responseBody = responseBody.reduce((acc, curr) => {
            acc.labels.push(curr["ACCESS_DATE"]);
            acc.data.push(curr["ACCESS_COUNT"]);
            return acc;
        }, {
            labels: [],
            data: []
        });

        return responseBody;

    } else {
        return alert("이전 접근 기록을 가져오는 중입니다.");
    }

};

