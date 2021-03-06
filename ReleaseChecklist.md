## Checklist for making a release:

### Requirements
 - [ ] Lauchpad (Ubuntu One) account
 - [ ] gnupg key (has to be version 1, gpg2 won't work) for `your-name@ethereum.org` created and uploaded
 - [ ] Readthedocs account, access to the Solidity project
 - [ ] Write access to https://github.com/ethereum/homebrew-ethereum

### Documentation check
 - [ ] Run `make linkcheck` from within `docs/` and fix any broken links it finds. Ignore false positives caused by `href` anchors and dummy links not meant to work.

### Blog Post
 - [ ] Create a post on https://github.com/ethereum/solidity-blog and explain some of the new features or concepts.

### Changelog
 - [ ] Sort the changelog entries alphabetically and correct any errors you notice.
 - [ ] Create a commit on a new branch that updates the ``Changelog`` to include a release date.
 - [ ] Run ``./scripts/tests.sh`` to update the bug list.
 - [ ] Create a pull request and wait for the tests, merge it.

### Create the Release
 - [ ] Create Github release page: https://github.com/ethereum/solidity/releases/new
 - [ ] On the release page, select the ``release`` branch as new target and set tag to the new version (e.g. `v0.5.4`) (make sure you only `SAVE DRAFT` instead of `PUBLISH RELEASE` before the actual release)
 - [ ] Thank voluntary contributors in the Github release page (use ``git shortlog -s -n -e origin/release..origin/develop``).
 - [ ] Create a pull request from ``develop`` to ``release``, wait for the tests, then merge it.
 - [ ] Make a final check that there are no platform-dependency issues in the ``solidity-test-bytecode`` repository.
 - [ ] Wait for the tests for the commit on ``release``, create a release in Github, creating the tag (click the `PUBLISH RELEASE` button on the release page.)
 - [ ] Wait for the CI runs on the tag itself (travis should push artifacts onto the Github release page).
 - [ ] Take the ``solc.exe`` binary from the ``b_win_release`` run of the released commit in circle-ci and add it to the release page as ``solc-windows.exe``.
 - [ ] Run ``scripts/create_source_tarball.sh`` while being on the tag to create the source tarball. Make sure to create ``prerelease.txt`` before: (``echo -n > prerelease.txt``). This will create the tarball in a directory called ``upload``.
 - [ ] Take the tarball from the upload directory (its name should be ``solidity_x.x.x.tar.gz``, otherwise ``prerelease.txt`` was missing in the step before) and upload the source tarball to the release page.

### Homebrew and MacOS
 - [ ] Update the version and the hash (``sha256sum solidity_x.x.x.tar.gz``) in https://github.com/ethereum/homebrew-ethereum/blob/master/solidity.rb
 - [ ] Take the binary from the ``b_osx`` run of the released commit in circle-ci and add it to the release page as ``solc-macos``.

### Update solc-bin
 - [ ] Copy ``soljson.js`` from the release page to ``solc-bin/bin/soljson-v<version>+commit.<commit>.js``
 - [ ] Copy ``solc-static-linux`` from the release page to ``solc-bin/linux-amd64/solc-linux-amd64-v<version>+commit.<commit>``
 - [ ] Copy ``solc-macos`` from the release page to ``solc-bin/macos-amd64/solc-macos-amd64-v<version>+commit.<commit>``
 - [ ] Copy ``solc-windows.zip`` from the release page to ``solc-bin/windows-amd64/solc-windows-amd64-v<version>+commit.<commit>.zip``
 - [ ] Make the linux and the macos binaries executable.
 - [ ] Run ``./update`` in ``solc-bin`` and verify that the script has updated ``list.js``, ``list.txt`` and ``list.json`` files correctly and that symlinks to the new release have been added in ``solc-bin/wasm/`` and ``solc-bin/emscripten-wasm32/``.
 - [ ] Create a pull request and merge.

### PPA
 - [ ] Change ``scripts/release_ppa.sh`` to match your key's email and key id.
 - [ ] Run ``scripts/release_ppa.sh release`` to create the PPA release (you need the relevant openssl key).
 - [ ] Wait for the ``~ethereum/ubuntu/ethereum-static`` PPA build to be finished and published for *all platforms*. SERIOUSLY: DO NOT PROCEED EARLIER!!! *After* the static builds are *published*, copy the static package to the ``~ethereum/ubuntu/ethereum`` PPA for the destination series ``Trusty`` and ``Xenial`` while selecting ``Copy existing binaries``.

### Docker
 - [ ] Check that the Docker release was pushed to Docker Hub (this still seems to have problems, run ``./scripts/docker_deploy_manual.sh v0.x.x``).

### Documentation
 - [ ] Build the new version on https://readthedocs.org/projects/solidity/ (select `latest` on the bottom of the page and click `BUILD`)
 - [ ] In the admin panel, select `Versions` in the menu and set the default version to the released one.

### Release solc-js
 - [ ] Increment the version number, create a pull request for that, merge it after tests succeeded.
 - [ ] Run ``npm publish`` in the updated ``solc-js`` repository.
 - [ ] Make sure to push the tag ``npm publish`` created with ``git push --tags``.

### Post-release
 - [ ] Publish the blog post.
 - [ ] Create a commit to increase the version number on ``develop`` in ``CMakeLists.txt`` and add a new skeleton changelog entry.
 - [ ] Merge ``release`` back into ``develop``.
 - [ ] Announce on Twitter and Reddit.
 - [ ] Lean back, wait for bug reports and repeat from step 1 :)
