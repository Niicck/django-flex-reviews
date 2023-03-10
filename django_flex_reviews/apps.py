from enum import Enum
from typing import Optional

from django.apps import AppConfig
from django.conf import settings


class DefaultSettings(Enum):
    """Default values for django.conf.settings introduced by django_flex_reviews."""

    """
    This is the default strategy that will applied to a new Review.
    Write in the form of a model string.
    Ex: "django_flex_reviews.strategies.ebert.models.EbertStrategy"

    If you use UserStrategyDefaults, you can more finely tune the default strategies
    per user, per media type.
    """
    DJANGO_FLEX_REVIEW_DEFAULT_STRATEGY: Optional[str] = None


def apply_default_settings() -> None:
    """Apply default setting values on app start up."""

    for setting in DefaultSettings:
        if not hasattr(settings, setting.name):
            setattr(settings, setting.name, setting.value)


class DjangoFlexReviewsConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "django_flex_reviews"

    def ready(self) -> None:
        apply_default_settings()
