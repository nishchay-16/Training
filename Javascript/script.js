// const loginBtn = document.getElementById('loginBtn');

// loginBtn.addEventListener('click', function() {
//     window.location.href = '/Html/login_page.html'; // Replace with the path to your login page
// });

document.addEventListener('DOMContentLoaded', function() {
    const loginBtn = document.getElementById('loginBtn');
    loginBtn.addEventListener('click', function() {
        window.location.href = '/Html/login_page.html'; // Replace with the path to your login page
    });

    const librarianBtn = document.getElementById('librarianBtn');
    librarianBtn.addEventListener('click', function() {
        window.location.href = '/Html/login_page.html?role=librarian';
    });

    const studentBtn = document.getElementById('studentBtn');
    studentBtn.addEventListener('click', function() {
        window.location.href = '/Html/login_page.html?role=student';
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const params = new URLSearchParams(window.location.search);
    const role = params.get('role');
    if (role) {
        document.querySelector(`input[name="role"][value="${role}"]`).checked = true;
    }
});