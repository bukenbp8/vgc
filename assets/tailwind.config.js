const colors = require("tailwindcss/colors");

module.exports = {
    mode: "jit",
    purge: ["./js/**/*.js", "../lib/*_web/**/*.*ex"],
    theme: {
        extend: {
            colors: {
                "light-blue": colors.sky,
                cyan: colors.cyan,
            },
        },
    },
    variants: {
        extend: {
            borderWidth: ["hover"],
        },
    },
};
