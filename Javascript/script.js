document.addEventListener('DOMContentLoaded', () => {
    const loginBtn = document.getElementById('loginBtn');
    if (loginBtn) {
        loginBtn.addEventListener('click', function () {
            window.location.href = '/Html/login.html';
        });
    }

    const librarianBtn = document.getElementById('librarianBtn');
    if (librarianBtn) {
        librarianBtn.addEventListener('click', function () {
            window.location.href = '/Html/login.html?role=librarian';
        });
    }

    const studentBtn = document.getElementById('studentBtn');
    if (studentBtn) {
        studentBtn.addEventListener('click', function () {
            window.location.href = '/Html/login.html?role=student';
        });
    }

    const params = new URLSearchParams(window.location.search);
    const role = params.get('role');
    if (role) {
        const roleInput = document.querySelector(`input[name="role"][value="${role}"]`);
        if (roleInput) {
            roleInput.checked = true;
        }
    }

    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', function (event) {
            event.preventDefault(); 
            window.location.href = '/Html/dashboard.html';
        });
    }

    const sideLinks = document.querySelectorAll('.sidebar .side-menu li a:not(.logout)');
    sideLinks.forEach(item => {
        const li = item.parentElement;
        item.addEventListener('click', () => {
            sideLinks.forEach(i => {
                i.parentElement.classList.remove('active');
            });
            li.classList.add('active');
        });
    });

    const menuBar = document.querySelector('.content nav .fa-solid.fa-bars');
    const sideBar = document.querySelector('.sidebar');
    if (menuBar && sideBar) {
        menuBar.addEventListener('click', () => {
            sideBar.classList.toggle('close');
        });
    }
});

function showDashboard() {
    document.getElementById('dashboard-content').style.display = 'block';
    document.getElementById('analytics-content').style.display = 'none';
    document.getElementById('profile-content').style.display = 'none';
    document.getElementById('info-content').style.display = 'none';
}

function showAnalytics() {
    document.getElementById('dashboard-content').style.display = 'none';
    document.getElementById('analytics-content').style.display = 'block';
    document.getElementById('profile-content').style.display = 'none';
    document.getElementById('info-content').style.display = 'none';
}

function showProfile() {
    document.getElementById('dashboard-content').style.display = 'none';
    document.getElementById('analytics-content').style.display = 'none';
    document.getElementById('profile-content').style.display = 'block';
    document.getElementById('info-content').style.display = 'none';
}

function showInfo() {
    document.getElementById('dashboard-content').style.display = 'none';
    document.getElementById('analytics-content').style.display = 'none';
    document.getElementById('profile-content').style.display = 'none';
    document.getElementById('info-content').style.display = 'block';
}

