# This can be set to load buildx build images to local docker as images.
LOAD_IMAGES_FROM_BUILDX=1

MULTI_ARCH=linux/amd64,linux/arm64/v8
#MULTI_ARCH=linux/amd64

NAME_CLI_PHP81 = sbuerk/test1-cli-core-testing-php81
GH_NAME_CLI_PHP81 = ghcr.io/sbuerk/test1-cli-core-testing-php81
MAJOR_CLI_PHP81=1
MINOR_CLI_PHP81=2
PATCHLEVEL_CLI_PHP81=0

NAME_FPM_PHP81 = sbuerk/test1-fpm-core-testing-php81
GH_NAME_FPM_PHP81 = ghcr.io/sbuerk/test1-fpm-core-testing-php81
MAJOR_FPM_PHP81=1
MINOR_FPM_PHP81=2
PATCHLEVEL_FPM_PHP81=0

NAME_APACHE_PHP81 = sbuerk/test1-apache-core-testing-php81
GH_NAME_APACHE_PHP81 = ghcr.io/sbuerk/test1-apache-core-testing-php81
MAJOR_APACHE_PHP81=1
MINOR_APACHE_PHP81=2
PATCHLEVEL_APACHE_PHP81=0

FULLVERSION_CLI_PHP81=$(MAJOR_CLI_PHP81).$(MINOR_CLI_PHP81).$(PATCHLEVEL_CLI_PHP81)
SHORTVERSION_CLI_PHP81=$(MAJOR_CLI_PHP81).$(MINOR_CLI_PHP81)
FULLVERSION_FPM_PHP81=$(MAJOR_FPM_PHP81).$(MINOR_FPM_PHP81).$(PATCHLEVEL_FPM_PHP81)
SHORTVERSION_FPM_PHP81=$(MAJOR_FPM_PHP81).$(MINOR_FPM_PHP81)
FULLVERSION_APACHE_PHP81=$(MAJOR_APACHE_PHP81).$(MINOR_APACHE_PHP81).$(PATCHLEVEL_APACHE_PHP81)
SHORTVERSION_APACHE_PHP81=$(MAJOR_APACHE_PHP81).$(MINOR_APACHE_PHP81)

.PHONY: \
	build \
	build_core_testing_cli_php81 \
	build_core_testing_fpm_php81 \
	build_core_testing_apache_php81 \
	release \
	release_core_testing_cli_php81 \
	release_core_testing_fpm_php81 \
	release_core_testing_apache_php81 \
	clean_images

all: \
	build

build: \
	build_core_testing_cli_php81 \
	build_core_testing_fpm_php81 \
	build_core_testing_apache_php81

release: \
	release_core_testing_cli_php81 \
	release_core_testing_fpm_php81 \
	release_core_testing_apache_php81

clean_images:
	@if ! docker buildx ls | grep core_testing; then \
		docker buildx create --name core_testing; \
	fi
	docker buildx use core_testing
	docker buildx prune -f

build_core_testing_cli_php81:
	@if ! docker buildx ls | grep core_testing; then \
		docker buildx create --name core_testing; \
	fi
	docker buildx use core_testing
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_CLI_PHP81):latest test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_CLI_PHP81):latest test1-cli-core-testing-php81
	@if [ $(LOAD_IMAGES_FROM_BUILDX) -eq 1 ]; then \
		docker buildx build --progress plain --load -t $(NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_CLI_PHP81):latest test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_CLI_PHP81):latest test1-cli-core-testing-php81 ; \
	fi

release_core_testing_cli_php81:
	@if ! docker buildx ls | grep core_testing; then \
		docker buildx create --name core_testing; \
	fi
	docker buildx use core_testing
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_CLI_PHP81):latest test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_CLI_PHP81):latest test1-cli-core-testing-php81
	@if [ $(LOAD_IMAGES_FROM_BUILDX) -eq 1 ]; then \
		docker buildx build --progress plain --load -t $(NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_CLI_PHP81):latest test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_CLI_PHP81):$(FULLVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_CLI_PHP81):$(SHORTVERSION_CLI_PHP81) test1-cli-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_CLI_PHP81):latest test1-cli-core-testing-php81 ; \
	fi

build_core_testing_fpm_php81:
	@if ! docker buildx ls | grep core_testing; then \
		docker buildx create --name core_testing; \
	fi
	docker buildx use core_testing
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_FPM_PHP81):latest test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_FPM_PHP81):latest test1-fpm-core-testing-php81
	@if [ $(LOAD_IMAGES_FROM_BUILDX) -eq 1 ]; then \
		docker buildx build --progress plain --load -t $(NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_FPM_PHP81):latest test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_FPM_PHP81):latest test1-fpm-core-testing-php81 ; \
	fi

release_core_testing_fpm_php81:
	@if ! docker buildx ls | grep core_testing; then \
		docker buildx create --name core_testing; \
	fi
	docker buildx use core_testing
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_FPM_PHP81):latest test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_FPM_PHP81):latest test1-fpm-core-testing-php81
	@if [ $(LOAD_IMAGES_FROM_BUILDX) -eq 1 ]; then \
		docker buildx build --progress plain --load -t $(NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_FPM_PHP81):latest test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_FPM_PHP81):$(FULLVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_FPM_PHP81):$(SHORTVERSION_FPM_PHP81) test1-fpm-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_FPM_PHP81):latest test1-fpm-core-testing-php81 ; \
	fi

build_core_testing_apache_php81:
	@if ! docker buildx ls | grep core_testing; then \
		docker buildx create --name core_testing; \
	fi
	docker buildx use core_testing
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(NAME_APACHE_PHP81):latest test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) -t $(GH_NAME_APACHE_PHP81):latest test1-apache-core-testing-php81
	@if [ $(LOAD_IMAGES_FROM_BUILDX) -eq 1 ]; then \
		docker buildx build --progress plain --load -t $(NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_APACHE_PHP81):latest test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_APACHE_PHP81):latest test1-apache-core-testing-php81 ; \
	fi

release_core_testing_apache_php81:
	@if ! docker buildx ls | grep core_testing; then \
		docker buildx create --name core_testing; \
	fi
	docker buildx use core_testing
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(NAME_APACHE_PHP81):latest test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81
	docker buildx build --progress plain --platform $(MULTI_ARCH) --push -t $(GH_NAME_APACHE_PHP81):latest test1-apache-core-testing-php81
	@if [ $(LOAD_IMAGES_FROM_BUILDX) -eq 1 ]; then \
		docker buildx build --progress plain --load -t $(NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(NAME_APACHE_PHP81):latest test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_APACHE_PHP81):$(FULLVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_APACHE_PHP81):$(SHORTVERSION_APACHE_PHP81) test1-apache-core-testing-php81 ; \
		docker buildx build --progress plain --load -t $(GH_NAME_APACHE_PHP81):latest test1-apache-core-testing-php81 ; \
	fi
