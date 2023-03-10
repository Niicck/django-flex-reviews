from django.contrib import admin
from django.db import models
from django.http import HttpRequest

from django_flex_reviews.reviews.forms import ReviewForm
from django_flex_reviews.reviews.models import Review


class ReviewAdmin(admin.ModelAdmin[Review]):
    list_display = ("media", "view_completed_at")
    form = ReviewForm

    @admin.display
    def view_completed_at(self, obj: Review) -> str:
        return obj.completed_at

    def get_queryset(self, request: HttpRequest) -> models.QuerySet[Review]:
        queryset = super().get_queryset(request)
        return queryset
