export const InitNotification = {
    mounted() {
        this.el.addEventListener("transitionend", (evt) => {
            evt.stopPropagation();
            const result = /flash-([\w]*)/.exec(evt.target.id);
            if (result) {
                const [_, key] = result;
                this.pushEvent("lv:clear-flash", { key: key });
            }
        });
        const handleOpenCloseEvent = event => {
            if (event.detail.open === false) {
                this.el.removeEventListener("modal-change", handleOpenCloseEvent)

                setTimeout(() => {
                    // This timeout gives time for the animation to complete
                    this.pushEventTo(event.detail.id, "close", {})
                }, 300);
            }
        }
    }
}