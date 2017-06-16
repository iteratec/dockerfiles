# Java8 JDK with Chrome stable and chromedriver

Can be used for headless chrome-based testing.

Although chrome has a native headless mode by now, chromedriver
still requires xvfb for `sendKeys` to work.
See https://bugs.chromium.org/p/chromedriver/issues/detail?id=1772 .

So you need to run your application with `xvfb-run` in front.
Example:

    xvfb-run --auto-servernum --server-args='-screen 0 1920x1080x24 -ac +extension RANDR' /my/application/using/chromdriver

Once this issue is resolved, xvfb will be removed from this image.

If you run chrome, make sure to use the `--no-sandbox` flag, as chrome doesn't work in docker otherwise.



