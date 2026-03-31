document.addEventListener('DOMContentLoaded', () => {
    const hoursElem = document.getElementById('hours');
    const minutesElem = document.getElementById('minutes');
    const secondsElem = document.getElementById('seconds');
    const ampmElem = document.getElementById('ampm');
    const dateElem = document.getElementById('date');

    const updateClock = () => {
        const now = new Date();
        
        let hours = now.getHours();
        const minutes = now.getMinutes();
        const seconds = now.getSeconds();
        
        // 12-hour format converting
        const ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12; // the hour '0' should be '12'

        // Format to string with leading zeros
        const formatZero = (num) => num.toString().padStart(2, '0');

        // Update DOM
        if (hoursElem.textContent !== formatZero(hours)) hoursElem.textContent = formatZero(hours);
        if (minutesElem.textContent !== formatZero(minutes)) minutesElem.textContent = formatZero(minutes);
        if (secondsElem.textContent !== formatZero(seconds)) secondsElem.textContent = formatZero(seconds);
        if (ampmElem.textContent !== ampm) ampmElem.textContent = ampm;

        // Date formatting
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const currentDateStr = now.toLocaleDateString('en-US', options);
        if (dateElem.textContent !== currentDateStr) {
            dateElem.textContent = currentDateStr;
        }

        // Use requestAnimationFrame for smooth, precise looping
        requestAnimationFrame(updateClock);
    };

    // Initialize clock immediately
    updateClock();
});
