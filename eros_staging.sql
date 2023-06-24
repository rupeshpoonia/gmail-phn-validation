/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;erros_staggingcampaigns
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `brand_profiles`;
CREATE TABLE `brand_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `stripe_customer_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_card_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_card_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaign_approval_contents`;
CREATE TABLE `campaign_approval_contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `type_of_content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL COMMENT '0 => pending, 1=> approve, 2=> reject',
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaign_chart_data`;
CREATE TABLE `campaign_chart_data` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint unsigned NOT NULL,
  `month_year` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_likes` bigint NOT NULL DEFAULT '0',
  `total_comments` bigint NOT NULL DEFAULT '0',
  `total_engagement_rate` decimal(9,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_chart_data_campaign_id_index` (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaign_hashtags`;
CREATE TABLE `campaign_hashtags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint unsigned NOT NULL,
  `hashtag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_hashtags_campaign_id_index` (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaign_join_type_of_contents`;
CREATE TABLE `campaign_join_type_of_contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `campaign_join_id` bigint unsigned NOT NULL,
  `type_of_content_id` bigint unsigned NOT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaign_joinings`;
CREATE TABLE `campaign_joinings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `campaign_id` bigint unsigned NOT NULL,
  `payout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `join_date` timestamp NULL DEFAULT NULL,
  `campaign_deadline` timestamp NULL DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_apt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `impression` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_joinings_user_id_index` (`user_id`),
  KEY `campaign_joinings_campaign_id_index` (`campaign_id`),
  CONSTRAINT `campaign_joinings_campaign_id_foreign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `campaign_joinings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaign_objectives`;
CREATE TABLE `campaign_objectives` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaign_type_of_contents`;
CREATE TABLE `campaign_type_of_contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type_content_id` bigint unsigned NOT NULL,
  `campaign_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_type_of_contents_type_content_id_index` (`type_content_id`),
  KEY `campaign_type_of_contents_campaign_id_index` (`campaign_id`),
  CONSTRAINT `campaign_type_of_contents_campaign_id_foreign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `campaign_type_of_contents_type_content_id_foreign` FOREIGN KEY (`type_content_id`) REFERENCES `type_of_contents` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `campaigns`;
CREATE TABLE `campaigns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `brand_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_budget` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `focus_of_content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `trackable_hashtag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requirement` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `codes_other_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `influencer_location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `influencer_city` int DEFAULT NULL,
  `audience_location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `audience_city` int DEFAULT NULL,
  `audience_age` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `audience_language` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign_deadline` timestamp NULL DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `similiar_image_4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `similiar_image_3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `similiar_image_2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `similiar_image_1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `like_count` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `post_quantity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `story_quantity` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `campaign_start` timestamp NULL DEFAULT NULL,
  `required_hashtags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ig_likes_count` bigint NOT NULL DEFAULT '0',
  `ig_comments_count` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `campaigns_brand_id_index` (`brand_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ch_favorites`;
CREATE TABLE `ch_favorites` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `favorite_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `ch_messages`;
CREATE TABLE `ch_messages` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_id` bigint NOT NULL,
  `to_id` bigint NOT NULL,
  `body` varchar(5000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cities_location_id_index` (`location_id`),
  CONSTRAINT `cities_location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `images`;
CREATE TABLE `images` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` bigint unsigned NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `images_brand_id_index` (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `influencer_interest_campaigns`;
CREATE TABLE `influencer_interest_campaigns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `target_interest_id` bigint unsigned NOT NULL,
  `campaign_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `influencer_interest_campaigns_target_interest_id_index` (`target_interest_id`),
  KEY `influencer_interest_campaigns_campaign_id_index` (`campaign_id`),
  CONSTRAINT `influencer_interest_campaigns_campaign_id_foreign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `influencer_interest_campaigns_target_interest_id_foreign` FOREIGN KEY (`target_interest_id`) REFERENCES `target_interests` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `influencer_payouts`;
CREATE TABLE `influencer_payouts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `static_post` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `carousel_post` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `static_story` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_story` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reels` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instagram_video` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `follower_max` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `follower_min` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `influencer_profiles`;
CREATE TABLE `influencer_profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `ig_app_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ig_user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ig_app_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ig_access_token` longtext COLLATE utf8mb4_unicode_ci,
  `ig_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ig_followers` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `ig_following` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `ig_engagement_rate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `ig_first_photo_uploaded` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ig_last_photo_uploaded` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unit_apt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `avg_likes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `avg_comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `total_comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `total_likes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `influencer_profiles_user_id_index` (`user_id`),
  CONSTRAINT `influencer_profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `influencer_transactions`;
CREATE TABLE `influencer_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `campaign_joining_id` bigint unsigned DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `amount` double(8,2) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `influencer_transactions_user_id_foreign` (`user_id`),
  CONSTRAINT `influencer_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `like_or_dislikes`;
CREATE TABLE `like_or_dislikes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `like` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `like_or_dislikes_campaign_id_index` (`campaign_id`),
  KEY `like_or_dislikes_user_id_index` (`user_id`),
  CONSTRAINT `like_or_dislikes_campaign_id_foreign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `like_or_dislikes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `locations`;
CREATE TABLE `locations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Inactive, 1=Active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `objective_campaigns`;
CREATE TABLE `objective_campaigns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `camaign_objective_id` bigint unsigned NOT NULL,
  `campaign_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `objective_campaigns_camaign_objective_id_index` (`camaign_objective_id`),
  KEY `objective_campaigns_campaign_id_index` (`campaign_id`),
  CONSTRAINT `objective_campaigns_camaign_objective_id_foreign` FOREIGN KEY (`camaign_objective_id`) REFERENCES `campaign_objectives` (`id`) ON DELETE CASCADE,
  CONSTRAINT `objective_campaigns_campaign_id_foreign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `recently_viewed_campaign`;
CREATE TABLE `recently_viewed_campaign` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint unsigned NOT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recently_viewed_campaign_campaign_id_index` (`campaign_id`),
  CONSTRAINT `recently_viewed_campaign_campaign_id_foreign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `stripe_accounts`;
CREATE TABLE `stripe_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `account_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_holder_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_holder_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fingerprint` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `routing_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `external_account_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stripe_accounts_user_id_foreign` (`user_id`),
  CONSTRAINT `stripe_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `subscription_logs`;
CREATE TABLE `subscription_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `subscription_plan_id` bigint unsigned NOT NULL,
  `subscription_plan_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscription_plan_price` int NOT NULL,
  `subscription_plan_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscription_plan_service_fee` int NOT NULL,
  `subscribe_till_date` date NOT NULL,
  `stripe_price_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_customer_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_sub_schedule` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `stripe_subscription_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redeem_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Active, 1=Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `subscription_plans`;
CREATE TABLE `subscription_plans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Month, Year',
  `service_fee` int NOT NULL,
  `stripe_price_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `subscription_plan_id` bigint unsigned NOT NULL,
  `subscribe_till_date` date NOT NULL,
  `stripe_sub_schedule` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `stripe_subscription_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `target_interest_influencers`;
CREATE TABLE `target_interest_influencers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `target_interest_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `target_interest_influencers_target_interest_id_index` (`target_interest_id`),
  KEY `target_interest_influencers_user_id_index` (`user_id`),
  CONSTRAINT `target_interest_influencers_target_interest_id_foreign` FOREIGN KEY (`target_interest_id`) REFERENCES `target_interests` (`id`) ON DELETE CASCADE,
  CONSTRAINT `target_interest_influencers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `target_interests`;
CREATE TABLE `target_interests` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `wallet_id` bigint unsigned NOT NULL,
  `amount` double unsigned NOT NULL DEFAULT '0',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `debit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `credit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `response` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tax` double(30,2) unsigned NOT NULL DEFAULT '0.00',
  `service_fee` double(30,2) unsigned NOT NULL DEFAULT '0.00',
  `service_fee_percentage` double(30,2) unsigned NOT NULL DEFAULT '0.00',
  `tax_percentage` double(30,2) unsigned NOT NULL DEFAULT '0.00',
  `campaign_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_user_id_index` (`user_id`),
  KEY `transactions_wallet_id_index` (`wallet_id`),
  CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `type_of_contents`;
CREATE TABLE `type_of_contents` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `person_contact` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `industry` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `brand_logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `about_brand` text COLLATE utf8mb4_unicode_ci,
  `brand_phone_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `influencer_avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_interest` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `terms_service` tinyint(1) NOT NULL,
  `role` tinyint NOT NULL DEFAULT '2' COMMENT '0=Brand, 1=influencer',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT '0',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'avatar.png',
  `dark_mode` tinyint(1) NOT NULL DEFAULT '0',
  `messenger_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscription_id` bigint unsigned NOT NULL DEFAULT '1',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `wallets`;
CREATE TABLE `wallets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `amount` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wallets_user_id_index` (`user_id`),
  CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `brand_profiles` (`id`, `user_id`, `stripe_customer_id`, `stripe_card_token`, `stripe_card_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'cus_O20WDh84eBKGaR', 'tok_1NFwWFDvw9vaoZphEYin9pkh', 'card_1NFwWFDvw9vaoZphuUw6zddK', '2023-05-17 08:21:51', '2023-06-06 09:49:40');
INSERT INTO `brand_profiles` (`id`, `user_id`, `stripe_customer_id`, `stripe_card_token`, `stripe_card_id`, `created_at`, `updated_at`) VALUES
(2, 3, 'cus_NxBeVJH0NH6wgu', 'tok_1NGEEjDvw9vaoZphAFcvNaTb', 'card_1NGEEjDvw9vaoZphOm31367W', '2023-05-17 08:28:57', '2023-06-07 04:44:46');
INSERT INTO `brand_profiles` (`id`, `user_id`, `stripe_customer_id`, `stripe_card_token`, `stripe_card_id`, `created_at`, `updated_at`) VALUES
(3, 4, 'cus_Nv8ZpKbh7hUEsH', 'tok_1N9IJ2Dvw9vaoZphrzcRVplD', 'card_1N9IJ2Dvw9vaoZph1LeSQgSW', '2023-05-17 14:01:17', '2023-05-19 01:40:32');
INSERT INTO `brand_profiles` (`id`, `user_id`, `stripe_customer_id`, `stripe_card_token`, `stripe_card_id`, `created_at`, `updated_at`) VALUES
(4, 7, 'cus_NuuC6Hfx8yMw4D', 'tok_1N94OdDvw9vaoZphKUWPBER7', 'card_1N94OdDvw9vaoZphIfcpn5VG', '2023-05-18 10:48:43', '2023-05-18 10:49:23'),
(5, 9, 'cus_NvCBL7bl5P1vvo', 'tok_1N9Mj0Dvw9vaoZphlJpTJOVL', NULL, '2023-05-19 05:23:50', '2023-05-19 07:07:43'),
(6, 12, 'cus_NvNTKNZR6u96Ow', 'tok_1N9WkeDvw9vaoZph1neKhtTL', 'card_1N9WkeDvw9vaoZphaw4YTlHj', '2023-05-19 17:03:52', '2023-05-19 17:06:01'),
(7, 15, 'cus_Nvujs3kqQltnRu', 'tok_1NA2vsDvw9vaoZphZydcQlU3', 'card_1NA2vsDvw9vaoZphTqOAaLT5', '2023-05-21 03:26:17', '2023-05-21 03:27:44'),
(8, 16, 'cus_NwOktY0OGFzlgq', NULL, NULL, '2023-05-22 10:26:33', '2023-05-22 10:26:33'),
(9, 17, 'cus_NwQKd9lPKxJWsZ', NULL, NULL, '2023-05-22 12:05:16', '2023-05-22 12:05:16'),
(10, 19, 'cus_NxBOi6ljIX15wd', 'tok_1NBH3YDvw9vaoZphGTkY6ncs', 'card_1NBH3YDvw9vaoZphhkC8PdEP', '2023-05-24 12:43:09', '2023-05-24 12:44:45'),
(11, 21, 'cus_NxmFkGHRrGPwzy', NULL, NULL, '2023-05-26 02:47:54', '2023-05-26 02:47:54'),
(12, 22, 'cus_NxtmTm2bvNZu6j', 'tok_1NBzKuDvw9vaoZphslGjnKLr', 'card_1NBzKuDvw9vaoZph3NTmdLvl', '2023-05-26 10:35:07', '2023-05-26 12:01:37'),
(13, 23, 'cus_NxtxiD4cWBUqwm', NULL, NULL, '2023-05-26 10:45:41', '2023-05-26 10:45:41'),
(14, 24, 'cus_Nxz9lbBcz6YbLP', NULL, NULL, '2023-05-26 16:08:19', '2023-05-26 16:08:19'),
(15, 25, 'cus_NzN01QEfN5eUnZ', 'tok_1NDOHJDvw9vaoZphp5ss4R4V', 'card_1NDOHJDvw9vaoZphAZ3nnW00', '2023-05-30 08:50:58', '2023-05-30 08:51:42'),
(16, 27, 'cus_NzfIE5Xddyr9H8', 'tok_1NDg2bDvw9vaoZph6h0mx0eo', 'card_1NDg2bDvw9vaoZphi2gMNjkC', '2023-05-31 03:45:04', '2023-05-31 03:49:41'),
(17, 28, 'cus_NzfWfIhSfYw6FJ', 'tok_1NDgCZDvw9vaoZph6pctJebU', 'card_1NDgCZDvw9vaoZphi2z4AI9U', '2023-05-31 03:58:25', '2023-05-31 04:00:00'),
(18, 32, 'cus_O0D641M00j09x4', NULL, NULL, '2023-06-01 14:40:59', '2023-06-01 14:40:59'),
(19, 33, 'cus_O0D9tfYJ3IUNL5', NULL, NULL, '2023-06-01 14:43:59', '2023-06-01 14:43:59'),
(20, 34, 'cus_O0bAykR7LyA48q', NULL, NULL, '2023-06-02 15:32:30', '2023-06-02 15:32:30'),
(21, 38, 'cus_O0bLPXIsS8FftB', NULL, NULL, '2023-06-02 15:43:45', '2023-06-02 15:43:45'),
(22, 45, 'cus_O21E7OT9ZVgbUl', NULL, NULL, '2023-06-06 10:32:33', '2023-06-06 10:32:33');

INSERT INTO `campaign_approval_contents` (`id`, `campaign_id`, `user_id`, `type_of_content`, `file`, `status`, `reason`, `created_at`, `updated_at`) VALUES
(1, 24, 5, 'Static Post', 'approval_content/rJoB4Tr9gRiV1WHhJaoDxyCXEDFapqaGGEQ6h4WP.png', 0, NULL, NULL, NULL);
INSERT INTO `campaign_approval_contents` (`id`, `campaign_id`, `user_id`, `type_of_content`, `file`, `status`, `reason`, `created_at`, `updated_at`) VALUES
(2, 24, 5, 'Carousel Post', 'approval_content/TRsZA1XCQhrV7EM7WpSyWrRw1aJQCIjNPdRt8dwZ.png', 0, NULL, NULL, NULL);
INSERT INTO `campaign_approval_contents` (`id`, `campaign_id`, `user_id`, `type_of_content`, `file`, `status`, `reason`, `created_at`, `updated_at`) VALUES
(3, 25, 5, 'Static Post', 'approval_content/Ap1MCbUz6q8dkgQVMSbEIr4v4T9u83qBquMiHVad.png', 0, NULL, NULL, NULL);
INSERT INTO `campaign_approval_contents` (`id`, `campaign_id`, `user_id`, `type_of_content`, `file`, `status`, `reason`, `created_at`, `updated_at`) VALUES
(4, 25, 5, 'Static Story', 'approval_content/PQdRSx9AtKFBdD5zzWG9u4LaIjUTiF8hh6UykHYt.png', 0, NULL, NULL, NULL),
(5, 25, 5, 'Reels', 'approval_content/sttnrNApx0j4G351ROsv9WogALzFPrt2lnpp06vp.mp4', 0, NULL, NULL, NULL),
(6, 27, 26, 'Instagram Video', 'approval_content/HXaWlkNRyrpXtSYjQPXgZGU7v3sKQsd8wj9s2I00.mp4', 2, 'does not pertain to my business. please create another video with the gift I sent you', NULL, '2023-06-02 17:31:37'),
(7, 25, 6, 'Reels', 'approval_content/DZ3aNBYjjgN1au3NRLvC6vP052pedoGww64DgH7B.jpg', 0, NULL, NULL, NULL),
(8, 25, 6, 'Reels', 'approval_content/jBrlxXPMGmYRPyW3NUnugDmephinje3qqytE0sdh.jpg', 0, NULL, NULL, NULL),
(9, 33, 26, 'Carousel Post', 'approval_content/Y0vPeDuXQ2tuJ2sqPe200924Q7gGffUCKiwp7FEA.jpg', 1, NULL, NULL, '2023-06-06 16:11:39');





INSERT INTO `campaign_join_type_of_contents` (`id`, `campaign_join_id`, `type_of_content_id`, `amount`, `created_at`, `updated_at`) VALUES
(1, 8, 2, '2.5', '2023-05-30 19:31:18', '2023-05-30 19:31:18');
INSERT INTO `campaign_join_type_of_contents` (`id`, `campaign_join_id`, `type_of_content_id`, `amount`, `created_at`, `updated_at`) VALUES
(2, 9, 1, '25', '2023-05-30 19:32:36', '2023-05-30 19:32:36');
INSERT INTO `campaign_join_type_of_contents` (`id`, `campaign_join_id`, `type_of_content_id`, `amount`, `created_at`, `updated_at`) VALUES
(3, 9, 2, '2.5', '2023-05-30 19:32:36', '2023-05-30 19:32:36');
INSERT INTO `campaign_join_type_of_contents` (`id`, `campaign_join_id`, `type_of_content_id`, `amount`, `created_at`, `updated_at`) VALUES
(4, 9, 5, '31', '2023-05-30 19:32:36', '2023-05-30 19:32:36'),
(5, 10, 1, '25', '2023-05-31 07:20:52', '2023-05-31 07:20:52'),
(6, 10, 2, '2.5', '2023-05-31 07:20:52', '2023-05-31 07:20:52'),
(7, 11, 1, '25', '2023-06-01 10:01:40', '2023-06-01 10:01:40'),
(8, 11, 2, '2.5', '2023-06-01 10:01:40', '2023-06-01 10:01:40'),
(9, 12, 1, '25', '2023-06-01 10:06:18', '2023-06-01 10:06:18'),
(10, 12, 2, '2.5', '2023-06-01 10:06:18', '2023-06-01 10:06:18'),
(11, 12, 3, '13', '2023-06-01 10:06:18', '2023-06-01 10:06:18'),
(12, 13, 2, '2.5', '2023-06-01 10:06:41', '2023-06-01 10:06:41'),
(13, 14, 1, '25', '2023-06-01 14:26:20', '2023-06-01 14:26:20'),
(14, 14, 2, '2.5', '2023-06-01 14:26:20', '2023-06-01 14:26:20'),
(15, 15, 1, '25', '2023-06-01 14:58:17', '2023-06-01 14:58:17'),
(16, 15, 3, '13', '2023-06-01 14:58:17', '2023-06-01 14:58:17'),
(17, 15, 5, '31', '2023-06-01 14:58:17', '2023-06-01 14:58:17'),
(18, 16, 2, '2.5', '2023-06-02 13:51:53', '2023-06-02 13:51:53'),
(19, 17, 1, '25', '2023-06-02 14:42:06', '2023-06-02 14:42:06'),
(20, 17, 2, '2.5', '2023-06-02 14:42:06', '2023-06-02 14:42:06'),
(21, 18, 1, '25', '2023-06-02 14:42:49', '2023-06-02 14:42:49'),
(22, 18, 3, '13', '2023-06-02 14:42:49', '2023-06-02 14:42:49'),
(23, 19, 6, '38', '2023-06-02 17:02:07', '2023-06-02 17:02:07'),
(24, 20, 6, '38', '2023-06-02 18:13:34', '2023-06-02 18:13:34'),
(25, 21, 5, '31', '2023-06-03 11:24:13', '2023-06-03 11:24:13'),
(26, 22, 2, '2.5', '2023-06-06 16:06:59', '2023-06-06 16:06:59');

INSERT INTO `campaign_joinings` (`id`, `user_id`, `campaign_id`, `payout`, `join_date`, `campaign_deadline`, `address`, `country`, `state`, `city`, `postal_code`, `unit_apt`, `campaign_type`, `impression`, `created_at`, `updated_at`) VALUES
(1, 5, 1, '2.5', '2023-05-19 02:08:07', '2023-05-19 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-19 02:08:07', '2023-05-19 02:08:07');
INSERT INTO `campaign_joinings` (`id`, `user_id`, `campaign_id`, `payout`, `join_date`, `campaign_deadline`, `address`, `country`, `state`, `city`, `postal_code`, `unit_apt`, `campaign_type`, `impression`, `created_at`, `updated_at`) VALUES
(2, 5, 2, '2.5', '2023-05-19 02:11:17', '2023-05-20 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-19 02:11:17', '2023-05-19 02:11:17');
INSERT INTO `campaign_joinings` (`id`, `user_id`, `campaign_id`, `payout`, `join_date`, `campaign_deadline`, `address`, `country`, `state`, `city`, `postal_code`, `unit_apt`, `campaign_type`, `impression`, `created_at`, `updated_at`) VALUES
(3, 5, 3, '25', '2023-05-19 02:15:09', '2023-05-20 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-19 02:15:10', '2023-05-19 02:15:10');
INSERT INTO `campaign_joinings` (`id`, `user_id`, `campaign_id`, `payout`, `join_date`, `campaign_deadline`, `address`, `country`, `state`, `city`, `postal_code`, `unit_apt`, `campaign_type`, `impression`, `created_at`, `updated_at`) VALUES
(4, 14, 5, '44.5', '2023-05-19 17:28:37', '2023-06-30 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-19 17:28:37', '2023-05-19 17:28:37'),
(5, 6, 1, '2.5', '2023-05-20 05:04:57', '2023-05-19 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-20 05:04:57', '2023-05-20 05:04:57'),
(6, 18, 1, '2.5', '2023-05-24 10:50:26', '2023-05-19 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2023-05-24 10:50:26', '2023-05-24 10:50:26'),
(7, 5, 15, '0', '2023-05-24 16:19:54', '2023-05-31 00:00:00', '28 Franca cres, Etobicoke, On M9V4S3', NULL, NULL, NULL, NULL, NULL, 'gift', 0, '2023-05-24 16:19:54', '2023-05-24 16:19:54'),
(8, 26, 19, '2.5', '2023-05-30 19:31:18', '2023-06-05 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-05-30 19:31:18', '2023-05-30 19:31:18'),
(9, 26, 20, '58.5', '2023-05-30 19:32:36', '2023-06-09 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-05-30 19:32:36', '2023-05-30 19:32:36'),
(10, 26, 24, '27.5', '2023-05-31 07:20:52', '2023-06-10 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-05-31 07:20:52', '2023-05-31 07:20:52'),
(11, 31, 24, '27.5', '2023-06-01 10:01:40', '2023-06-10 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-01 10:01:40', '2023-06-01 10:01:40'),
(12, 31, 22, '40.5', '2023-06-01 10:06:18', '2023-06-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-01 10:06:18', '2023-06-01 10:06:18'),
(13, 31, 19, '2.5', '2023-06-01 10:06:41', '2023-06-05 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-01 10:06:41', '2023-06-01 10:06:41'),
(14, 5, 24, '27.5', '2023-06-01 14:26:19', '2023-06-10 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-01 14:26:20', '2023-06-01 14:26:20'),
(15, 5, 25, '69', '2023-06-01 14:58:17', '2023-06-23 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-01 14:58:17', '2023-06-01 14:58:17'),
(16, 5, 22, '2.5', '2023-06-02 13:51:53', '2023-06-01 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-02 13:51:53', '2023-06-02 13:51:53'),
(17, 26, 24, '27.5', '2023-06-02 14:42:06', '2023-06-10 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-02 14:42:06', '2023-06-02 14:42:06'),
(18, 26, 25, '38', '2023-06-02 14:42:49', '2023-06-23 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-02 14:42:49', '2023-06-02 14:42:49'),
(19, 26, 27, '38', '2023-06-02 17:02:07', '2023-06-20 00:00:00', 'this is my address', NULL, NULL, NULL, NULL, NULL, 'Paid + Gift', 0, '2023-06-02 17:02:07', '2023-06-02 17:02:07'),
(20, 5, 27, '38', '2023-06-02 18:13:34', '2023-06-20 00:00:00', '28 Franca cres, Etobicoke ON M9V4S3', NULL, NULL, NULL, NULL, NULL, 'Paid + Gift', 0, '2023-06-02 18:13:34', '2023-06-02 18:13:34'),
(21, 6, 25, '31', '2023-06-03 11:24:13', '2023-06-23 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-03 11:24:13', '2023-06-03 11:24:13'),
(22, 26, 33, '2.5', '2023-06-06 16:06:59', '2023-06-28 00:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'paid', 0, '2023-06-06 16:06:59', '2023-06-06 16:06:59');

INSERT INTO `campaign_objectives` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Build Brand Awareness', NULL, NULL);
INSERT INTO `campaign_objectives` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Increase Conversions/Sales', NULL, NULL);
INSERT INTO `campaign_objectives` (`id`, `name`, `created_at`, `updated_at`) VALUES
(3, 'Increase Social Media following', NULL, NULL);
INSERT INTO `campaign_objectives` (`id`, `name`, `created_at`, `updated_at`) VALUES
(4, 'Promote a Launch', NULL, NULL),
(5, 'Promote an Event', NULL, NULL),
(6, 'Expand into New Markets', NULL, NULL),
(7, 'Acquire New Users', NULL, NULL);

INSERT INTO `campaign_type_of_contents` (`id`, `type_content_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2023-05-17 00:00:00', '2023-05-17 00:00:00');
INSERT INTO `campaign_type_of_contents` (`id`, `type_content_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(2, 2, 2, '2023-05-18 00:00:00', '2023-05-18 00:00:00');
INSERT INTO `campaign_type_of_contents` (`id`, `type_content_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(3, 1, 3, '2023-05-18 00:00:00', '2023-05-18 00:00:00');
INSERT INTO `campaign_type_of_contents` (`id`, `type_content_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(4, 2, 4, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(5, 1, 5, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(6, 2, 5, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(7, 4, 5, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(8, 1, 6, '2023-05-21 00:00:00', '2023-05-21 00:00:00'),
(9, 1, 7, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(10, 1, 8, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(11, 2, 8, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(12, 1, 9, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(13, 2, 9, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(14, 2, 10, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(15, 3, 10, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(16, 2, 11, '2023-05-23 00:00:00', '2023-05-23 00:00:00'),
(17, 4, 12, '2023-05-23 00:00:00', '2023-05-23 00:00:00'),
(18, 1, 13, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(19, 2, 13, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(20, 5, 14, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(21, 1, 15, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(22, 2, 15, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(23, 2, 16, '2023-05-25 00:00:00', '2023-05-25 00:00:00'),
(24, 1, 17, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(25, 2, 17, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(26, 3, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(27, 4, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(28, 5, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(29, 2, 19, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(30, 1, 20, '2023-05-29 00:00:00', '2023-05-29 00:00:00'),
(31, 2, 20, '2023-05-29 00:00:00', '2023-05-29 00:00:00'),
(32, 5, 20, '2023-05-29 00:00:00', '2023-05-29 00:00:00'),
(33, 1, 21, '2023-05-30 00:00:00', '2023-05-30 00:00:00'),
(34, 1, 22, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(35, 2, 22, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(36, 3, 22, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(37, 1, 23, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(38, 2, 23, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(39, 1, 24, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(40, 2, 24, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(41, 1, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(42, 3, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(43, 5, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(44, 1, 26, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(45, 2, 26, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(46, 3, 26, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(47, 6, 27, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(48, 1, 28, '2023-06-03 00:00:00', '2023-06-03 00:00:00'),
(49, 1, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(50, 2, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(51, 1, 30, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(52, 2, 30, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(53, 5, 30, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(54, 1, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(55, 2, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(56, 3, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(57, 4, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(58, 5, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(59, 6, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(60, 1, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(61, 2, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(62, 3, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(63, 1, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(64, 2, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(65, 5, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(66, 1, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(67, 2, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(68, 3, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(69, 4, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(70, 1, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(71, 2, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(72, 3, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(73, 4, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00');

INSERT INTO `campaigns` (`id`, `brand_id`, `name`, `brand_name`, `campaign_type`, `total_budget`, `summary`, `focus_of_content`, `trackable_hashtag`, `requirement`, `codes_other_info`, `influencer_location`, `influencer_city`, `audience_location`, `audience_city`, `audience_age`, `audience_language`, `campaign_deadline`, `image`, `similiar_image_4`, `similiar_image_3`, `similiar_image_2`, `similiar_image_1`, `like_count`, `status`, `created_at`, `updated_at`, `post_quantity`, `story_quantity`, `campaign_start`, `required_hashtags`, `profile_tags`, `ig_likes_count`, `ig_comments_count`) VALUES
(1, 4, 'Uday', 'Cp', 'paid', '1000', 'Hello', 'Software', '#codepaper1233', 'write hello', '123', '1', NULL, '1', NULL, '18', 'English', '2023-05-19 00:00:00', 'campaign/bitqkTqSumHSAE9WHpE8vrSJXzpNAG5iOmdpQ0Cw.svg', NULL, NULL, NULL, '1684332644_EROS LOGO.png', 1, 1, '2023-05-17 14:10:44', '2023-05-19 01:58:34', NULL, NULL, '2023-05-17 00:00:00', NULL, '@codepapercom', 0, 0);
INSERT INTO `campaigns` (`id`, `brand_id`, `name`, `brand_name`, `campaign_type`, `total_budget`, `summary`, `focus_of_content`, `trackable_hashtag`, `requirement`, `codes_other_info`, `influencer_location`, `influencer_city`, `audience_location`, `audience_city`, `audience_age`, `audience_language`, `campaign_deadline`, `image`, `similiar_image_4`, `similiar_image_3`, `similiar_image_2`, `similiar_image_1`, `like_count`, `status`, `created_at`, `updated_at`, `post_quantity`, `story_quantity`, `campaign_start`, `required_hashtags`, `profile_tags`, `ig_likes_count`, `ig_comments_count`) VALUES
(2, 3, 'sandy', 'sandy campany', 'paid', '3456', 'sdfg', 'ghg', 'Eros_Marketing_YIygZ', 'khk', 'jkjk', '1', NULL, '1', NULL, '18-24', 'English', '2023-05-20 00:00:00', 'campaign/TAUPe0hm4hQLIwPjHfNvHlajsDOswS1c3wqCUR5o.png', NULL, NULL, NULL, '1684412377_Screenshot 2023-05-17 at 4.37.57 PM.png', 3, 1, '2023-05-18 12:19:37', '2023-06-06 10:38:54', NULL, NULL, '2023-05-19 00:00:00', NULL, 'jhjk', 0, 0);
INSERT INTO `campaigns` (`id`, `brand_id`, `name`, `brand_name`, `campaign_type`, `total_budget`, `summary`, `focus_of_content`, `trackable_hashtag`, `requirement`, `codes_other_info`, `influencer_location`, `influencer_city`, `audience_location`, `audience_city`, `audience_age`, `audience_language`, `campaign_deadline`, `image`, `similiar_image_4`, `similiar_image_3`, `similiar_image_2`, `similiar_image_1`, `like_count`, `status`, `created_at`, `updated_at`, `post_quantity`, `story_quantity`, `campaign_start`, `required_hashtags`, `profile_tags`, `ig_likes_count`, `ig_comments_count`) VALUES
(3, 1, 'rupesh', 'codepaper', 'paid', '54', 'fhg', 'hj', 'Eros_Marketing_JXUHZ', 'fgjh', 'fdhdfhgf', '1', NULL, '1', NULL, '18-24', 'English', '2023-05-20 00:00:00', 'campaign/VqM5iqUgqzyWkYbpoWkaXiUwpT4lzVL9wWnbyQp7.png', NULL, NULL, NULL, '1684413039_first page.png', 1, 1, '2023-05-18 12:30:39', '2023-06-06 10:19:32', NULL, NULL, '2023-05-19 00:00:00', NULL, 'ghj', 0, 0);
INSERT INTO `campaigns` (`id`, `brand_id`, `name`, `brand_name`, `campaign_type`, `total_budget`, `summary`, `focus_of_content`, `trackable_hashtag`, `requirement`, `codes_other_info`, `influencer_location`, `influencer_city`, `audience_location`, `audience_city`, `audience_age`, `audience_language`, `campaign_deadline`, `image`, `similiar_image_4`, `similiar_image_3`, `similiar_image_2`, `similiar_image_1`, `like_count`, `status`, `created_at`, `updated_at`, `post_quantity`, `story_quantity`, `campaign_start`, `required_hashtags`, `profile_tags`, `ig_likes_count`, `ig_comments_count`) VALUES
(4, 9, 'rerer', 'newcustomer1@gmail.com', 'paid', '66', 'nmbnm', 'yu', 'Eros_Marketing_Gwvhf', 'ytu', 'utyu', '2', NULL, '1', NULL, '18-24', 'English', '2023-05-21 00:00:00', 'campaign/xIgs5ca1isMekT43xnYZzMOfI6GMl6GwNjntdxU8.jpg', NULL, NULL, NULL, '1684490595_images.jpg', 1, 1, '2023-05-19 10:03:16', '2023-05-24 16:25:13', NULL, NULL, '2023-05-20 00:00:00', NULL, 'yutu', 0, 0),
(5, 12, 'jacksonmall', 'CP', 'paid', '1000', 'hello', 'Ye', 'Eros_Marketing_udtLs', 'Hello there', NULL, '1', NULL, '1', NULL, '55-64', 'English', '2023-06-30 00:00:00', 'campaign/XfhvqU805TwTAP8BfOdQq1lE0HEHE3jUOlD533hB.png', NULL, NULL, NULL, '1684516231_227 prompts to 10x your Freelance revenue and Reduce Cost with ChatGPT.png', 0, 1, '2023-05-19 17:10:31', '2023-05-19 17:19:14', NULL, NULL, '2023-05-30 00:00:00', NULL, 'Codepapercom, Codepaper', 0, 0),
(6, 15, 'dcdd', 'starbucks.com', 'paid', '500', 'dcdccd', 'Dan dan noodle', 'Eros_Marketing_bmDFL', 'Showcasing an omelette', NULL, '1', NULL, '1', NULL, '18-24', 'English', '2023-06-08 00:00:00', 'campaign/tqIcVmserFpcxpfFe7h3MeoSORArZo3f1Agm5o7X.jpg', NULL, NULL, NULL, '1684644361_download.jpeg', 1, 1, '2023-05-21 04:46:01', '2023-05-24 11:17:47', NULL, NULL, '2023-05-29 00:00:00', NULL, NULL, 0, 0),
(7, 16, 'Campaign Name', 'Codepaper', 'paid', '500', '<p>Campaign Summary</p>', '<p>Focus of Content</p>', 'Eros_Marketing_brUfu', '<p>Requirements</p>', 'code', '1', NULL, '1', NULL, '25-34', 'English', '2023-05-25 00:00:00', 'campaign/HNI9lRRvB8bb1n9wePM83Xo1mefbKObm633UzNA0.jpg', '1684751546_pexels-tom-fisk-1519753.jpg', '1684751545_pexels-tom-fisk-1519753 - Copy.jpg', '1684751545_pexels-tom-fisk-1519753 - Copy (3).jpg', '1684751545_pexels-tom-fisk-1519753 - Copy (2).jpg', 0, 0, '2023-05-22 10:32:26', '2023-05-22 10:32:26', NULL, NULL, '2023-05-22 00:00:00', NULL, 'profile', 0, 0),
(8, 15, 'Campaign 1', 'starbucks.com', 'paidgift', '850', '<p><strong>The goal of this campaign is to promote our business through sponsored posts featuring our products. Through this collaboration, we hope to increase brand awareness and drive sales among a highly engaged and targeted audience.</strong></p>', '<p><strong>The focus of the content for this campaign should be on showcasing our new line of cosmetics in a creative and engaging way. We encourage you to use your unique style and voice to highlight the features and benefits of our products, while also incorporating them into your daily routine or makeup looks. We would like to see a mix of product close-ups, tutorials, and lifestyle shots that demonstrate the versatility and quality of our cosmetics. Please ensure that all content is in line with our brand values and messaging.</strong></p>', 'Eros_Marketing_adJTO', '<ul><li><p><strong>Create and publish a minimum of 3 sponsored posts featuring our products on your Instagram feed over the course of the campaign.</strong></p></li><li><p><strong>Include at least one Instagram story highlight showcasing our products and linking to our website.</strong></p></li><li><p><strong>Use the designated campaign hashtags and tag our brand in all sponsored posts.</strong></p></li><li><p><strong>Provide us with a report at the end of the campaign detailing engagement metrics such as likes, comments, and clicks.</strong></p></li><li><p><strong>Adhere to all FTC guidelines regarding disclosure of sponsored content.</strong></p></li></ul>', NULL, '1', NULL, '1', NULL, '18-24, 25-34', 'English', '2023-06-19 00:00:00', 'campaign/8TQR7ZfmSvuS1cOqNZTQVVHzZWDrQUbHoBd3kd0m.jpg', '1684766553_THAIROOM IMAGE5.jpeg', '1684766553_THAIROOM IMAGE4.jpeg', '1684766553_THAIROOM IMAGE3.jpeg', '1684766553_THAIROOM IMAGE2.jpeg', 1, 1, '2023-05-22 14:42:33', '2023-05-24 12:23:42', NULL, NULL, '2023-05-29 00:00:00', NULL, NULL, 0, 0),
(9, 15, 'sdfsdfdsfsfs', 'starbucks.com', 'gift', '0', '<p>sdfdfsffsfsfsf</p>', '<p>sdfdsfsdffsfsf</p>', 'Eros_Marketing_STuoQ', '<p>sdfdsfdsfsfsfsfs</p>', 'sdfdsfsdf', '1', NULL, '1', NULL, '18-24, 25-34', 'English', '2023-06-08 00:00:00', 'campaign/5pnOmr3AsATzn663YJazciIO9gXgt9KAf2kB97l7.jpg', NULL, NULL, NULL, '1684777694_THAIROOM IMAGE3.jpeg', 0, 1, '2023-05-22 17:48:14', '2023-06-02 17:26:43', NULL, NULL, '2023-05-23 00:00:00', NULL, 'sdfsdfsdfsfsfsf', 0, 0),
(10, 15, 'Eros Influencer Marketing', 'starbucks.com', 'paid', '34442', '<p>adfdfasfsafda</p>', '<p>asdfsadff</p>', 'Eros_Marketing_dgqdc', '<p>safasfa</p>', NULL, '1', NULL, '1', NULL, '18-24, 25-34, 35-44', 'English', '2023-06-07 00:00:00', 'campaign/CDFH6IV4NVAI7VZVgEjJNRWndT3iwe93A7kAT5TM.jpg', NULL, NULL, NULL, '1684778221_THAIROOM IMAGE3.jpeg', 0, 1, '2023-05-22 17:57:01', '2023-05-22 18:12:33', NULL, NULL, '2023-05-29 00:00:00', NULL, NULL, 0, 0),
(11, 16, 'vijay', 'Codepaper', 'gift', '0', '<p>Campaign Summary</p>', '<p>&nbsp;</p><p>Focus of Content</p>', 'Eros_Marketing_ZzPzL', '<p>Requirements</p>', 'code', '1', NULL, '1', NULL, '45-54', 'English', '2023-06-01 00:00:00', 'campaign/fcFn9bpAlw2zn65o5yBlOmHY7PdDts1fQV1gzoMh.jpg', NULL, NULL, NULL, '1684817075_phone.jpg', 0, 0, '2023-05-23 04:44:35', '2023-05-23 04:44:35', NULL, NULL, '2023-05-23 00:00:00', NULL, 'profile', 0, 0),
(12, 3, 'hfgh', 'sandy campany', 'paid', '6546', '<p>fghhgf</p>', '<p>gfdgfd</p>', 'Eros_Marketing_HvXVT', '<p>gdfg</p>', 'gdfg', '2', NULL, '2', NULL, '25-34', 'English', '2023-05-30 00:00:00', 'campaign/lsVYjfKjad0M743FUKTBsPTtc5qhYSUeBgHLLUNg.jpg', NULL, NULL, NULL, '1684844227_1000_F_567863595_HNhRLWopnTjNnRR3raRK3qm0kEoJnN08.jpg', 0, 0, '2023-05-23 12:17:07', '2023-05-23 12:17:07', NULL, NULL, '2023-05-23 00:00:00', NULL, 'gdfg', 0, 0),
(13, 15, 'Campaign name 2', 'starbucks.com', 'paid', '500', '<p><strong>The goal of this campaign is to promote our business through sponsored posts featuring our products. Through this collaboration, we hope to increase brand awareness and drive sales among a highly engaged and targeted audience</strong></p>', '<p><strong>The focus of the content for this campaign should be on showcasing our new line of cosmetics in a creative and engaging way. We encourage you to use your unique style and voice to highlight the features and benefits of our products, while also incorporating them into your daily routine or makeup looks. We would like to see a mix of product close-ups, tutorials, and lifestyle shots that demonstrate the versatility and quality of our cosmetics. Please ensure that all content is in line with our brand values and messaging.</strong></p>', 'Eros_Marketing_MsxmS', '<ul><li><p><strong>Create and publish a minimum of 3 sponsored posts featuring our products on your Instagram feed over the course of the campaign.</strong></p></li><li><p><strong>Include at least one Instagram story highlight showcasing our products and linking to our website.</strong></p></li><li><p><strong>Use the designated campaign hashtags and tag our brand in all sponsored posts.</strong></p></li><li><p><strong>Provide us with a report at the end of the campaign detailing engagement metrics such as likes, comments, and clicks.</strong></p></li><li><p><strong>Adhere to all FTC guidelines regarding disclosure of sponsored content.</strong></p></li></ul>', NULL, '1', NULL, '1', NULL, '18-24, 25-34, 35-44', 'English', '2023-06-05 00:00:00', 'campaign/fZ7fTbYFH9VgEhQ20q0pJTb1laX0tDER4TlIxrE4.jpg', '1684931630_RESTAURANTMARKETINGIMAGE1.png', '1684931630_ApolloX_toronto_based_influencer_taking_a_picture_of_greek_food_85e733ab-d259-4961-9c60-25cd7dfbef4b.png', '1684931630_lorenzo.negro_blogger_vs_influencer_54e94f3d-2f9b-4ba9-94c1-2aba18f7a029.png', '1684931630_OpenMike_owl_instagram_influencer_9e2c88b6-e5a6-4df3-8609-da8226ce483d.png', 0, 1, '2023-05-24 12:33:51', '2023-05-24 12:37:02', NULL, NULL, '2023-05-29 00:00:00', NULL, NULL, 0, 0),
(14, 19, 'My first Campaign', 'company name 2', 'paid', '1000', '<p><strong>The goal of this campaign is to promote our business through sponsored posts featuring our products. Through this collaboration, we hope to increase brand awareness and drive sales among a highly engaged and targeted audience</strong></p>', '<p><strong>The focus of the content for this campaign should be on showcasing our new line of cosmetics in a creative and engaging way. We encourage you to use your unique style and voice to highlight the features and benefits of our products, while also incorporating them into your daily routine or makeup looks. We would like to see a mix of product close-ups, tutorials, and lifestyle shots that demonstrate the versatility and quality of our cosmetics. Please ensure that all content is in line with our brand values and messaging.</strong></p>', 'Eros_Marketing_SlkGZ', '<ul><li><p><strong>Create and publish a minimum of 3 sponsored posts featuring our products on your Instagram feed over the course of the campaign.</strong></p></li><li><p><strong>Include at least one Instagram story highlight showcasing our products and linking to our website.</strong></p></li><li><p><strong>Use the designated campaign hashtags and tag our brand in all sponsored posts.</strong></p></li><li><p><strong>Provide us with a report at the end of the campaign detailing engagement metrics such as likes, comments, and clicks.</strong></p></li><li><p><strong>Adhere to all FTC guidelines regarding disclosure of sponsored content.</strong></p></li></ul>', 'code123', '1', NULL, '1', NULL, '18-24', 'English', '2023-06-30 00:00:00', 'campaign/84eYLvtrzbfoudAYbKg33cU5apkv0ZZyQWl00Kaj.png', NULL, '1684932547_Final Post.mp4', '1684932547_Post 1.mp4', '1684932547_Post 2.mp4', 0, 1, '2023-05-24 12:49:07', '2023-05-24 12:51:23', NULL, NULL, '2023-06-05 00:00:00', NULL, 'johnrocks', 0, 0),
(15, 4, 'Hello', 'Cp', 'gift', '0', '<p><strong>Hello</strong></p><p>Please follow the following:</p><ul><li><em>123</em></li><li><em>456</em></li></ul><p>Please follow all this</p>', '<p>Focus on Software development</p>', 'Eros_Marketing_wbFbC', '<p>Please add this 4 words in the campaign</p><ul><li>hello</li><li>123&#39;</li><li>456</li><li>890</li></ul><p>Olease follow to the full</p>', '123', '1', NULL, '1', NULL, '25-34, 35-44, 45-54', 'English', '2023-05-31 00:00:00', 'campaign/KkIza9Tlhopa7R8NYhuhYdvX9YpYd3fekwN2Q5wi.png', NULL, NULL, NULL, '1684944474_kova-logo-black.svg', 1, 1, '2023-05-24 16:07:54', '2023-05-24 16:25:12', NULL, NULL, '2023-05-25 00:00:00', NULL, '@codepapercom', 0, 0),
(16, 7, 'M22', 'Vishal', 'paid', '44', '<p>tyu</p>', '<p>test</p>', 'Eros_Marketing_OmGEE', '<p>tset</p>', NULL, '1', NULL, '1', NULL, '18-24', 'English', '2023-05-29 00:00:00', 'campaign/Ok0x5KSB8fJuyL5xBNtMiwHhPGQXAwn0cAOXc4LG.webp', NULL, NULL, NULL, '1684994779_01haunted_320_011414113109.webp', 0, 0, '2023-05-25 06:06:19', '2023-05-25 06:06:19', NULL, NULL, '2023-05-25 00:00:00', NULL, NULL, 0, 0),
(17, 21, 'fghfghfghfh', 'Google', 'paid', '188', '<p>fghdfghdhdhdfgh</p>', '<p>fgdhdfghdfghdfghdfghdfgh</p>', 'Eros_Marketing_BHIqb', '<p>dfghfdghfdghgfhdfh</p>', 'dfghfdghhgfdhd', '1', NULL, '1', NULL, '18-24', 'English', '2023-06-09 00:00:00', 'campaign/MDJmHazXGDKKKN1TsTCNagb8qC5wwzyLvj3bawyc.jpg', '1685069371_shutterstock_1427184032.jpg', '1685069371_shutterstock_1216383211.jpg', '1685069371_shutterstock_2154229797.jpg', '1685069371_shutterstock_1377903968.jpg', 0, 1, '2023-05-26 02:49:31', '2023-05-26 02:52:05', NULL, NULL, '2023-05-30 00:00:00', 'fdghdfghdfghdfg', 'dfghfdhdfghdfhg', 0, 0),
(18, 7, 'dassda', 'Vishal', 'gift', '0', '<p>jjjjj</p>', '<p>jj</p>', 'Eros_Marketing_EXnMF', '<p>jj</p>', 'jj', '2', NULL, '2', NULL, '35-44', 'English', '2023-05-27 00:00:00', 'campaign/JpnbALU0VcNqysZiUC8iGBzwNh3YajtqI3h2zHgl.jpg', NULL, NULL, NULL, '1685092488_1565805225-love_birds.webp', 0, 0, '2023-05-26 09:14:48', '2023-05-26 09:14:48', NULL, NULL, '2023-05-26 00:00:00', 'jj', 'lll', 0, 0),
(19, 24, 'Starbucks Test Campaign 1', 'The Best Company', 'paid', '800', '<p><strong>The goal of this campaign is to promote our business through sponsored posts featuring our products. Through this collaboration, we hope to increase brand awareness and drive sales among a highly engaged and targeted audience.</strong></p>', '<p><strong>The focus of the content for this campaign should be on showcasing our new line of cosmetics in a creative and engaging way. We encourage you to use your unique style and voice to highlight the features and benefits of our products, while also incorporating them into your daily routine or makeup looks. We would like to see a mix of product close-ups, tutorials, and lifestyle shots that demonstrate the versatility and quality of our cosmetics. Please ensure that all content is in line with our brand values and messaging</strong></p>', 'Eros_Marketing_jSoRn', '<ul><li><p><strong>Create and publish a minimum of 3 sponsored posts featuring our products on your Instagram feed over the course of the campaign.</strong></p></li><li><p><strong>Include at least one Instagram story highlight showcasing our products and linking to our website.</strong></p></li><li><p><strong>Use the designated campaign hashtags and tag our brand in all sponsored posts.</strong></p></li><li><p><strong>Provide us with a report at the end of the campaign detailing engagement metrics such as likes, comments, and clicks.</strong></p></li><li><p><strong>Adhere to all FTC guidelines regarding disclosure of sponsored content.</strong></p></li></ul>', 'starbucks15', '1', NULL, '1', NULL, '18-24, 25-34', 'English', '2023-06-05 00:00:00', 'campaign/dknsMjV9eunZpXIoYuhGOUq0MQ2UoGi5SgG6x0ce.jpg', '1685117900_190430143629-starbucks-dragon-drink-summer-menu-trnd.jpeg', '1685117900_starbucks-hangover-drinks-1606246701.png', '1685117900_download.jpeg', '1685117900_starbucks-drink-with-caramel_Olena-Bohovyk_Pexels.jpeg', 0, 1, '2023-05-26 16:18:20', '2023-05-26 16:21:18', NULL, NULL, '2023-05-29 00:00:00', 'dragonfruitdrink starbucks', 'stabuckscanada', 0, 0),
(20, 15, 'Another Campaign Name', 'starbucks.com', 'paid', '700', '<p><strong>The goal of this campaign is to promote our business through sponsored posts featuring our products. Through this collaboration, we hope to increase brand awareness and drive sales among a highly engaged and targeted audience</strong></p>', '<p><strong>The focus of the content for this campaign should be on showcasing our new line of cosmetics in a creative and engaging way. We encourage you to use your unique style and voice to highlight the features and benefits of our products, while also incorporating them into your daily routine or makeup looks. We would like to see a mix of product close-ups, tutorials, and lifestyle shots that demonstrate the versatility and quality of our cosmetics. Please ensure that all content is in line with our brand values and messaging.</strong></p>', 'Eros_Marketing_xDsbK', '<ul><li><p><strong>Create and publish a minimum of 3 sponsored posts featuring our products on your Instagram feed over the course of the campaign.</strong></p></li><li><p><strong>Include at least one Instagram story highlight showcasing our products and linking to our website.</strong></p></li><li><p><strong>Use the designated campaign hashtags and tag our brand in all sponsored posts.</strong></p></li><li><p><strong>Provide us with a report at the end of the campaign detailing engagement metrics such as likes, comments, and clicks.</strong></p></li><li><p><strong>Adhere to all FTC guidelines regarding disclosure of sponsored content.</strong></p></li></ul>', 'code1', '1', NULL, '1', NULL, '18-24, 25-34', 'English', '2023-06-09 00:00:00', 'campaign/M7STyZHgF8hx76oRVi2XVZwSCU79FfBpo2966Pgy.png', NULL, '1685329036_Final Post.mp4', '1685329036_Post 1.mp4', '1685329036_Post 2.mp4', 1, 1, '2023-05-29 02:57:16', '2023-05-29 02:58:52', NULL, NULL, '2023-06-05 00:00:00', 'hashtag hashtag2', 'dumplinghouse', 0, 0),
(21, 16, 'vijay', 'Codepaper', 'paid', '500', '<p>Campaign Summary</p>', '<p>Focus of Content</p>', 'Eros_Marketing_kFUge', '<p>Requirements</p>', NULL, '1', NULL, '1', NULL, '18-24', 'English', '2023-05-31 00:00:00', 'campaign/T9YmLXus57xs3Vwfx3kGWk71XoMtH9EykopKnFS3.jpg', NULL, NULL, NULL, '1685452956_car.jpg', 0, 0, '2023-05-30 13:22:36', '2023-05-30 13:22:36', NULL, NULL, '2023-05-30 00:00:00', 'hastag', NULL, 0, 0),
(22, 27, 'Campaign Name', 'Codepaper', 'paid', '150', '<p>Campaign Summary</p>', '<p>Focus of Content</p>', 'Eros_Marketing_dsZug', '<p>Requirements</p>', NULL, '1', NULL, '1', NULL, '18-24, 25-34', 'English', '2023-06-01 00:00:00', 'campaign/G2dvgPYFypELsaUopKEEcKJUOIlNtLECC0AOwSM9.jpg', NULL, NULL, NULL, '1685505511_car.jpg', 0, 1, '2023-05-31 03:58:31', '2023-05-31 04:03:24', NULL, NULL, '2023-05-31 00:00:00', 'hastag', NULL, 0, 0),
(23, 28, 'rupesh', 'codepaper', 'paid', '0', '<p>this is summary</p>', '<p>&nbsp;</p><p>Focus of Content</p>', 'Eros_Marketing_QSSna', '<p>&nbsp;</p><p>Requirements</p>', 'Codes & Other info', '1', NULL, '1', NULL, '18-24', 'English', '2023-06-10 00:00:00', 'campaign/zzKi3H6RgT247vF9FnbbwAduUkwonyudBriEdRtR.jpg', '1685506006_rear-view-programmer-working-all-night-long.jpg', '1685506006_blackcatcoders.jpg', '1685506006_blckcat.jpg', '1685506006_spooky-tree-against-big-moon.jpg', 0, 1, '2023-05-31 04:06:46', '2023-05-31 04:13:01', NULL, NULL, '2023-05-31 00:00:00', 'Required Hashtag', 'RequiredHashtag', 0, 0),
(24, 25, 'Niyo', 'Niyo Global', 'paid', '2125', '<p>Test</p>', '<p>dfdfdsfdsf</p>', 'Eros_Marketing_PtJGp', '<p>dfdsfdsfdsfdsf</p>', NULL, '1', NULL, '1', NULL, '25-34, 35-44, 45-54', 'English', '2023-06-10 00:00:00', 'campaign/mZCOvWQwSANMcIh1AtivZHXsG9kyiy18pTPOUvBb.jpg', NULL, NULL, NULL, '1685517129_4455.jpg', 1, 1, '2023-05-31 07:12:09', '2023-06-01 10:01:50', NULL, NULL, '2023-06-05 00:00:00', 'niyo', NULL, 0, 0),
(25, 33, 'uday', 'Codepaper', 'paid', '150', '<p>Hello there</p><ol><li>123</li><li>123</li><li>456</li></ol><p>Please follow this</p>', '<p>hello</p>', 'Eros_Marketing_OPlDw', '<p>Post hello in caption</p>', '1234', '1', NULL, '1', NULL, '25-34, 35-44, 45-54', 'English', '2023-06-23 00:00:00', 'campaign/mrA2yMrAQa7fX0atwcatDM5bydrHmzBgrugIAmyS.png', '1685631416_Sinup Page Influencers.png', '1685631416_Sinup Page Brands.png', '1685631416_Post 2.mp4', '1685631416_Post 1.mp4', 1, 1, '2023-06-01 14:56:56', '2023-06-02 14:43:13', NULL, NULL, '2023-06-01 00:00:00', 'hello, Codepapercom', 'codepapercom', 0, 0),
(26, 4, 'Hello', 'Cp', 'paid', '1000', '<p>Hello</p>', '<p>hello</p>', 'Eros_Marketing_XjIzQ', '<p>Hello</p>', '123', '1', NULL, '1', NULL, '18-24, 25-34, 35-44', 'English', '2023-06-08 00:00:00', 'campaign/G6FsiZofI5ewBAUzXq0bqoTlci72Y6kYPof0QOWt.png', '1685714882_Sinup Page Influencers.png', '1685714882_Sinup Page Brands.png', '1685714882_Post 2.mp4', '1685714882_Post 1.mp4', 0, 0, '2023-06-02 14:08:02', '2023-06-02 14:08:02', NULL, NULL, '2023-06-02 00:00:00', 'hello', 'codepapercom', 0, 0),
(27, 34, 'healthy food', 'hello foods', 'paidgift', '200', '<p>i want to increase conversions and sales. will provide meals</p>', '<p>showcase healthy meals</p>', 'Eros_Marketing_IIzNi', '<p>Must use hastags and link to our instagram page and website</p>', NULL, '1', NULL, '1', NULL, '18-24, 25-34, 35-44', 'English', '2023-06-20 00:00:00', 'campaign/6f8dlUJyOS7ekYzSNBJYU1lvNCpTT6PsB3AKpC97.jpg', NULL, NULL, NULL, '1685721811_article_291139_the-top-10-healthiest-foods-for-kids_-02-4b745e57928c4786a61b47d8ba920058 (3).jpg', 0, 1, '2023-06-02 16:03:31', '2023-06-02 17:00:36', NULL, NULL, '2023-06-02 00:00:00', NULL, NULL, 0, 0),
(28, 16, 'Campaign Name', 'Codepaper', 'paid', '500', '<p>Campaign Summary</p>', '<p>Focus of Content</p>', 'Eros_Marketing_WtYuA', '<p>Requirements</p>', NULL, '1', NULL, '1', NULL, '18-24', 'English', '2023-06-17 00:00:00', 'campaign/KXyqhlIEeWK5nrO7hlRoO0nKGFeVAMdNcjwpkXMQ.jpg', NULL, NULL, NULL, '1685796135_car.jpg', 0, 0, '2023-06-03 12:42:15', '2023-06-03 12:42:15', NULL, NULL, '2023-06-03 00:00:00', NULL, NULL, 0, 0),
(29, 1, 'test', 'codepaper', 'gift', '0', '<p>&nbsp;</p><p>Campaign Summary</p>', '<p>&nbsp;</p><p>Focus of Content</p>', 'Eros_Marketing_lpdDO', '<p>&nbsp;</p><p>Requirements</p>', NULL, '1', NULL, '1', NULL, '18-24', 'English', '2023-06-15 00:00:00', 'campaign/5rD46AiG4sbu6xTWnRkQCAwOyDG25OnW1nVzbuei.jpg', '1686045204_1960x0.jpg', '1686045204_modern-office-space-interior.jpg', '1686045204_blackcatcoders.jpg', '1686045204_blckcat.jpg', 0, 1, '2023-06-06 09:53:24', '2023-06-06 10:19:50', NULL, NULL, '2023-06-06 00:00:00', NULL, NULL, 0, 0),
(30, 7, 'Manoj', 'Vishal', 'gift', '0', '<p>yrty</p>', '<p>fhfgh</p>', 'Eros_Marketing_mmEhm', '<p>fghfgh</p>', 'gfhgh', '1', NULL, '1', NULL, '18-24, 25-34, 35-44, 45-54', 'English', '2023-06-13 00:00:00', 'campaign/0aYsO85DA7fgqNWV6Z2a8LXa34tktkBvfqFDjIwi.png', NULL, NULL, NULL, '1686045294_WhatsApp Image 2022-11-03 at 11.18.44 AM.jpeg', 0, 0, '2023-06-06 09:54:54', '2023-06-06 09:54:54', NULL, NULL, '2023-06-08 00:00:00', 'lll', 'hfgh', 0, 0),
(31, 7, 'Manoj', 'Vishal', 'gift', '0', '<p>gg</p>', '<p>ggsdfsdfs</p>', 'Eros_Marketing_QMUBI', '<p>ggsdfsdfs</p>', 'ggfsdfsdfsdf', '1', NULL, '1', NULL, '45-54', 'English', '2023-06-21 00:00:00', 'campaign/eaDzAuEOqVPp7V1RKp1NOCc1F8Ghza15kR1RLNHb.jpg', NULL, NULL, NULL, '1686046551_WhatsApp Image 2022-11-03 at 11.18.44 AM.jpeg', 0, 0, '2023-06-06 10:15:51', '2023-06-06 10:15:51', NULL, NULL, '2023-06-06 00:00:00', 'ggsdfsdf', 'ggfdfdfsdfs', 0, 0),
(32, 7, 'Manoj22', 'Vishal', 'gift', '0', '<p>hffgh</p>', '<p>ff</p>', 'Eros_Marketing_RaucX', '<p>ff</p>', 'ff', '1', NULL, '1', NULL, '25-34, 45-54', 'English', '2023-06-30 00:00:00', 'campaign/zmVwWWoqBi0VQRfUGq53ur3FkUSPgMjLIRwdimnd.jpg', NULL, NULL, NULL, '1686046924_WhatsApp Image 2022-11-03 at 11.18.44 AM (1).jpeg', 0, 0, '2023-06-06 10:22:04', '2023-06-06 10:22:04', NULL, NULL, '2023-06-14 00:00:00', 'fff', 'ff', 0, 0),
(33, 15, 'Campaign NAME 1', 'starbucks.com', 'paid', '1000', '<p><strong>The goal of this campaign is to promote our business through sponsored posts featuring our products. Through this collaboration, we hope to increase brand awareness and drive sales among a highly engaged and targeted audience</strong></p>', '<p>The focus of the content for this campaign should be on showcasing our new line of cosmetics in a creative and engaging way. We encourage you to use your unique style and voice to highlight the features and benefits of our products, while also incorporating them into your daily routine or makeup looks. We would like to see a mix of product close-ups, tutorials, and lifestyle shots that demonstrate the versatility and quality of our cosmetics. Please ensure that all content is in line with our brand values and messaging.</p>', 'Eros_Marketing_vfjon', '<ul><li><p>Create and publish a minimum of 3 sponsored posts featuring our products on your Instagram feed over the course of the campaign.</p></li><li><p>Include at least one Instagram story highlight showcasing our products and linking to our website.</p></li><li><p>Use the designated campaign hashtags and tag our brand in all sponsored posts.</p></li><li><p>Adhere to all FTC guidelines regarding disclosure of sponsored content.</p></li></ul>', 'code123', '1', NULL, '1', NULL, '18-24, 25-34, 35-44', 'English', '2023-06-28 00:00:00', 'campaign/0UVPXWWaHGUpxfYQypg86lssj93BdFaBqoQNhNx1.jpg', '1686067381_Final Post.mp4', '1686067381_Post 1.mp4', '1686067381_shutterstock_1972623956.jpg', '1686067381_shutterstock_1736626433.jpg', 1, 1, '2023-06-06 16:03:01', '2023-06-06 16:06:52', NULL, NULL, '2023-06-06 00:00:00', 'dumplinghousefood dumplinghousegerrards dumplinghousenorthyork', 'dumplinghouse', 0, 0),
(34, 7, 'dassda', 'Vishal', 'gift', '0', '<p>sfsdf</p>', '<p>dsfsd</p>', 'Eros_Marketing_JWTVt', '<p>sdffsd</p>', 'sdfsdf', '1', NULL, '1', NULL, '25-34, 35-44, 45-54', 'English', '2023-06-26 00:00:00', 'campaign/fojZW99VDLT1Pd1LMPqPfezQrUmXyRblzIZfySaI.webp', NULL, NULL, NULL, '1686107952_imag.webp', 0, 0, '2023-06-07 03:19:12', '2023-06-07 03:19:12', NULL, NULL, '2023-06-07 00:00:00', 'fdssdf', 'sdfsdf', 0, 0),
(35, 7, 'dassda', 'Vishal', 'gift', '0', '<p>dsfsdf</p>', '<p>sdfsdf</p>', 'Eros_Marketing_GtpUb', '<p>sdfsd</p>', 'sdfsdf', '1', NULL, '1', NULL, '25-34, 35-44, 45-54', 'English', '2023-06-28 00:00:00', 'campaign/GaEoOJL27jkLylDGSzNgYrRbDXIcHdMRn0h05rCB.webp', NULL, NULL, NULL, '1686112776_imag.webp', 0, 1, '2023-06-07 04:39:36', '2023-06-07 04:39:47', NULL, NULL, '2023-06-07 00:00:00', 'sdfsdf', 'sdffsd', 0, 0);

INSERT INTO `ch_favorites` (`id`, `user_id`, `favorite_id`, `created_at`, `updated_at`) VALUES
('01a7216c-0e7c-4ada-9935-9040865c99cf', 26, 24, '2023-05-30 19:31:18', '2023-05-30 19:31:18');
INSERT INTO `ch_favorites` (`id`, `user_id`, `favorite_id`, `created_at`, `updated_at`) VALUES
('0619ead5-a1b4-4c89-80e1-24315cf83d9d', 25, 31, '2023-06-01 10:01:40', '2023-06-01 10:01:40');
INSERT INTO `ch_favorites` (`id`, `user_id`, `favorite_id`, `created_at`, `updated_at`) VALUES
('0c6d02f1-12bf-430d-a90b-4a5bc6beb5af', 5, 33, '2023-06-01 14:58:17', '2023-06-01 14:58:17');
INSERT INTO `ch_favorites` (`id`, `user_id`, `favorite_id`, `created_at`, `updated_at`) VALUES
('0caf78ff-e6d0-4d0a-af3b-36b4afdb2b44', 26, 15, '2023-05-30 19:32:36', '2023-05-30 19:32:36'),
('1ddd006b-f4ec-45ea-ba26-3d456ed18720', 33, 5, '2023-06-01 14:58:17', '2023-06-01 14:58:17'),
('29545afa-2060-451d-99e6-5d453d4761d4', 34, 26, '2023-06-02 17:02:07', '2023-06-02 17:02:07'),
('32167c67-0d54-436f-96d3-2b49e06c57e1', 27, 31, '2023-06-01 10:06:18', '2023-06-01 10:06:18'),
('3255a2c0-b1da-4fc7-858d-7d0d9a203ea8', 5, 25, '2023-06-01 14:26:20', '2023-06-01 14:26:20'),
('3f4981b5-0502-45ba-b95c-e2e4a57b25c9', 6, 33, '2023-06-03 11:24:13', '2023-06-03 11:24:13'),
('4ac1590e-8f25-4324-93ea-4bf18fe5a39d', 15, 26, '2023-05-30 19:32:36', '2023-05-30 19:32:36'),
('5727924c-460e-4187-a689-3c89efe4f823', 34, 5, '2023-06-02 18:13:34', '2023-06-02 18:13:34'),
('5b40c7b3-5fac-481f-94db-5fff8935646e', 25, 5, '2023-06-01 14:26:20', '2023-06-01 14:26:20'),
('6357d6b9-08ca-4dd0-9019-a18dc45fc5c6', 26, 34, '2023-06-02 17:02:07', '2023-06-02 17:02:07'),
('63c872ea-e3bc-4634-8b9e-bd476af894e7', 31, 24, '2023-06-01 10:06:41', '2023-06-01 10:06:41'),
('6af3cc9b-543f-4622-9708-feb3ed6da61b', 27, 5, '2023-06-02 13:51:53', '2023-06-02 13:51:53'),
('7da2106b-eec7-43cd-9669-abff461390c4', 24, 26, '2023-05-30 19:31:18', '2023-05-30 19:31:18'),
('899d2d9e-6495-48e4-8802-36b40af48788', 26, 25, '2023-05-31 07:20:52', '2023-05-31 07:20:52'),
('89ada04e-a2ab-4a26-9775-10b3e6dc5601', 26, 33, '2023-06-02 14:42:49', '2023-06-02 14:42:49'),
('8f0060e3-1053-4067-b6e0-1cd9823ee024', 25, 26, '2023-05-31 07:20:52', '2023-05-31 07:20:52'),
('93a6a8d8-33eb-45bc-bc62-0cc8c2d91d90', 5, 34, '2023-06-02 18:13:34', '2023-06-02 18:13:34'),
('93b42e81-dfdb-4313-b787-eaaa5ea3f2f7', 31, 27, '2023-06-01 10:06:18', '2023-06-01 10:06:18'),
('965b5972-1922-46e2-ad80-0f3f74a69b11', 24, 31, '2023-06-01 10:06:41', '2023-06-01 10:06:41'),
('adc13592-fa16-4d4d-957a-1934d91504cd', 33, 6, '2023-06-03 11:24:13', '2023-06-03 11:24:13'),
('b3b71ef9-2fa5-46b9-bba5-48e2fddd1a03', 5, 27, '2023-06-02 13:51:53', '2023-06-02 13:51:53'),
('c57e5b8b-26a2-4d9e-b5b4-34ef19c6635d', 31, 25, '2023-06-01 10:01:40', '2023-06-01 10:01:40'),
('cd1b21aa-fcfd-45df-a304-776ffb7275ee', 33, 26, '2023-06-02 14:42:49', '2023-06-02 14:42:49');

INSERT INTO `ch_messages` (`id`, `from_id`, `to_id`, `body`, `attachment`, `seen`, `created_at`, `updated_at`) VALUES
('12fa4c59-f32b-4c9e-9118-c8d66fe13389', 5, 25, '', '{\"new_name\":\"63417245-fc7d-450e-923f-b6ce2c456c45.png\",\"old_name\":\"Sinup Page Brands.png\"}', 0, '2023-06-01 14:29:06', '2023-06-01 14:29:06');
INSERT INTO `ch_messages` (`id`, `from_id`, `to_id`, `body`, `attachment`, `seen`, `created_at`, `updated_at`) VALUES
('240d91d5-b08f-470c-b897-60012a0412b5', 15, 26, 'hi amazing work!', NULL, 1, '2023-05-30 19:34:05', '2023-05-30 19:34:16');
INSERT INTO `ch_messages` (`id`, `from_id`, `to_id`, `body`, `attachment`, `seen`, `created_at`, `updated_at`) VALUES
('321e3b03-f181-42f8-9c76-adbb6dacc7b7', 5, 25, 'Hello', NULL, 0, '2023-06-01 14:28:49', '2023-06-01 14:28:49');
INSERT INTO `ch_messages` (`id`, `from_id`, `to_id`, `body`, `attachment`, `seen`, `created_at`, `updated_at`) VALUES
('447ff1bc-f31c-4b42-8ae6-4ae0e21f8e50', 26, 15, 'test message', NULL, 1, '2023-05-30 19:33:38', '2023-05-30 19:33:55'),
('50fd6162-bb25-4af4-a28a-7eef44bd7a36', 34, 26, 'Great pls send me the correct video', NULL, 1, '2023-06-02 17:33:44', '2023-06-02 17:33:45'),
('582b738d-4d83-4c91-ac64-ba80e903168a', 26, 34, 'hi love this campaign!', NULL, 1, '2023-06-02 17:33:24', '2023-06-02 17:33:30'),
('7335b939-e169-4ad2-ba9e-6b9d68c8995d', 5, 33, 'hello trhere', NULL, 0, '2023-06-01 14:58:29', '2023-06-01 14:58:29'),
('868a222c-852d-4c81-a260-4a56e80e5c1a', 5, 25, 'ðŸ¤—', NULL, 0, '2023-06-01 14:29:55', '2023-06-01 14:29:55'),
('e2e25a26-71c4-45c5-ad0f-4d779cd9e254', 5, 33, '', '{\"new_name\":\"c7bcd163-86fe-4d81-a9e2-f688c877aa6a.png\",\"old_name\":\"Sinup Page Brands.png\"}', 0, '2023-06-01 14:58:36', '2023-06-01 14:58:36'),
('eb6a50e2-ef74-4d09-9285-deb16c4c2f6f', 26, 24, 'test message', NULL, 0, '2023-05-30 19:33:30', '2023-05-30 19:33:30');

INSERT INTO `cities` (`id`, `location_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'Toronto', '2023-05-26 09:24:39', '2023-05-26 09:24:39');
INSERT INTO `cities` (`id`, `location_id`, `name`, `created_at`, `updated_at`) VALUES
(2, 1, 'Ottawa', '2023-05-26 09:24:39', '2023-05-26 09:24:39');
INSERT INTO `cities` (`id`, `location_id`, `name`, `created_at`, `updated_at`) VALUES
(3, 1, 'Mississauga', '2023-05-26 09:24:39', '2023-05-26 09:24:39');
INSERT INTO `cities` (`id`, `location_id`, `name`, `created_at`, `updated_at`) VALUES
(4, 1, 'Brampton', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(5, 1, 'Hamilton', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(6, 1, 'London', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(7, 1, 'Markham', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(8, 1, 'Vaughan', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(9, 1, 'Kitchener', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(10, 1, 'Windsor', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(11, 1, 'Oshawa', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(12, 1, 'Guelph', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(13, 1, 'Thunder Bay', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(14, 1, 'St. Catharines', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(15, 1, 'Brantford', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(16, 1, 'Waterloo', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(17, 1, 'Kingston', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(18, 1, 'Barrie', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(19, 1, 'Stratford', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(20, 1, 'Cornwall', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(21, 1, 'Ajax', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(22, 1, 'Pickering', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(23, 1, 'London', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(24, 1, 'Newmarket', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(25, 1, 'Chatham-Kent', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(26, 1, 'Sarnia', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(27, 1, 'Peterborough', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(28, 1, 'Welland', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(29, 1, 'North Bay', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(30, 1, 'Sudbury', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(31, 1, 'Windsor', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(32, 1, 'Thunder Bay', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(33, 1, 'Timmins', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(34, 1, 'London', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(35, 1, 'Hamilton', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(36, 1, 'Kitchener', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(37, 1, 'Guelph', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(38, 1, 'Oshawa', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(39, 1, 'Brampton', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(40, 1, 'Mississauga', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(41, 1, 'Ottawa', '2023-05-26 09:24:39', '2023-05-26 09:24:39'),
(42, 1, 'Toronto', '2023-05-26 09:24:39', '2023-05-26 09:24:39');





INSERT INTO `influencer_interest_campaigns` (`id`, `target_interest_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(1, 11, 1, '2023-05-17 00:00:00', '2023-05-17 00:00:00');
INSERT INTO `influencer_interest_campaigns` (`id`, `target_interest_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(2, 24, 2, '2023-05-18 00:00:00', '2023-05-18 00:00:00');
INSERT INTO `influencer_interest_campaigns` (`id`, `target_interest_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(3, 2, 3, '2023-05-18 00:00:00', '2023-05-18 00:00:00');
INSERT INTO `influencer_interest_campaigns` (`id`, `target_interest_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(4, 2, 4, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(5, 11, 5, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(6, 22, 6, '2023-05-21 00:00:00', '2023-05-21 00:00:00'),
(7, 1, 7, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(8, 22, 8, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(9, 23, 9, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(10, 11, 10, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(11, 2, 11, '2023-05-23 00:00:00', '2023-05-23 00:00:00'),
(12, 11, 12, '2023-05-23 00:00:00', '2023-05-23 00:00:00'),
(13, 22, 13, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(14, 2, 14, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(15, 11, 15, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(16, 24, 16, '2023-05-25 00:00:00', '2023-05-25 00:00:00'),
(17, 1, 17, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(18, 24, 17, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(19, 2, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(20, 24, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(21, 5, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(22, 19, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(23, 24, 19, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(24, 11, 19, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(25, 22, 19, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(26, 22, 20, '2023-05-29 00:00:00', '2023-05-29 00:00:00'),
(27, 1, 21, '2023-05-30 00:00:00', '2023-05-30 00:00:00'),
(28, 2, 21, '2023-05-30 00:00:00', '2023-05-30 00:00:00'),
(29, 2, 22, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(30, 2, 23, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(31, 24, 23, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(32, 11, 23, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(33, 1, 24, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(34, 2, 24, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(35, 2, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(36, 24, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(37, 11, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(38, 2, 26, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(39, 24, 26, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(40, 9, 27, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(41, 22, 27, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(42, 21, 27, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(43, 10, 27, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(44, 1, 28, '2023-06-03 00:00:00', '2023-06-03 00:00:00'),
(45, 1, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(46, 2, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(47, 2, 30, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(48, 7, 30, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(49, 19, 30, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(50, 24, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(51, 1, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(52, 2, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(53, 24, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(54, 11, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(55, 5, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(56, 7, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(57, 19, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(58, 16, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(59, 23, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(60, 6, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(61, 9, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(62, 24, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(63, 11, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(64, 9, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(65, 22, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(66, 1, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(67, 2, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(68, 24, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(69, 11, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(70, 1, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(71, 2, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(72, 24, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00');

INSERT INTO `influencer_payouts` (`id`, `static_post`, `carousel_post`, `static_story`, `video_story`, `reels`, `instagram_video`, `follower_max`, `follower_min`, `created_at`, `updated_at`) VALUES
(1, '25', '2.5', '13', '17', '31', '38', '500', '0', '2023-05-09 11:27:44', '2023-05-09 11:27:44');
INSERT INTO `influencer_payouts` (`id`, `static_post`, `carousel_post`, `static_story`, `video_story`, `reels`, `instagram_video`, `follower_max`, `follower_min`, `created_at`, `updated_at`) VALUES
(2, '50', '5', '25', '33', '63', '75', '1000', '501', '2023-05-09 11:28:55', '2023-05-09 11:28:55');
INSERT INTO `influencer_payouts` (`id`, `static_post`, `carousel_post`, `static_story`, `video_story`, `reels`, `instagram_video`, `follower_max`, `follower_min`, `created_at`, `updated_at`) VALUES
(3, '75', '7.5', '38', '50', '94', '113', '1500', '1001', '2023-05-09 11:29:35', '2023-05-09 11:29:35');
INSERT INTO `influencer_payouts` (`id`, `static_post`, `carousel_post`, `static_story`, `video_story`, `reels`, `instagram_video`, `follower_max`, `follower_min`, `created_at`, `updated_at`) VALUES
(4, '100', '10', '50', '67', '125', '150', '2000', '1501', '2023-05-09 11:29:57', '2023-05-09 11:29:57'),
(5, '125', '12.5', '63', '83', '156', '188', '2500', '2001', '2023-05-09 11:30:14', '2023-05-09 11:30:14'),
(6, '150', '15', '75', '100', '188', '225', '3000', '2501', '2023-05-09 11:30:41', '2023-05-09 11:30:41'),
(7, '175', '17.50', '88', '117', '219', '263', '3500', '3001', '2023-05-16 11:21:05', '2023-05-16 11:21:06'),
(8, '200', '20.00', '100', '133', '250', '300', '4000', '3501', '2023-05-16 11:25:14', '2023-05-16 11:25:15'),
(9, '225', '22.50', '113', '150', '281', '338', '4500', '4001', '2023-05-16 11:25:16', '2023-05-16 11:25:16'),
(10, '250', '25.00', '125', '167', '313', '375', '5000', '4501', '2023-05-16 11:25:17', '2023-05-16 11:25:18'),
(11, '275', '27.50', '138', '183', '344', '413', '5500', '5001', '2023-05-16 11:25:20', '2023-05-16 11:25:18'),
(12, '300', '30.00', '150', '200', '375', '450', '6000', '5501', '2023-05-16 11:25:21', '2023-05-16 11:25:21'),
(13, '325', '32.50', '163', '217', '406', '488', '6500', '6001', '2023-05-16 11:25:21', '2023-05-16 11:25:30'),
(14, '350', '35.00', '175', '233', '438', '525', '7000', '6501', '2023-05-16 11:25:22', '2023-05-16 11:25:30'),
(15, '375', '37.50', '188', '250', '469', '563', '7500', '7001', '2023-05-16 11:25:22', '2023-05-16 11:25:29'),
(16, '400', '40.00', '200', '267', '500', '600', '8000', '7501', '2023-05-16 11:25:23', '2023-05-16 11:25:28'),
(17, '425', '42.50', '213', '283', '531', '638', '8500', '8001', '2023-05-16 11:25:23', '2023-05-16 11:25:28'),
(18, '450', '45.00', '225', '300', '563', '675', '9000', '8501', '2023-05-16 11:25:24', '2023-05-16 11:25:27'),
(19, '475', '47.50', '238', '317', '594', '713', '9500', '9001', '2023-05-16 11:25:25', '2023-05-16 11:25:27'),
(20, '500', '50.00', '250', '333', '625', '750', '10000', '9501', '2023-05-16 11:25:25', '2023-05-16 11:25:26');

INSERT INTO `influencer_profiles` (`id`, `user_id`, `ig_app_id`, `ig_user_id`, `ig_app_secret`, `ig_access_token`, `ig_username`, `ig_followers`, `ig_following`, `ig_engagement_rate`, `ig_first_photo_uploaded`, `ig_last_photo_uploaded`, `street_address`, `unit_apt`, `postal_code`, `city`, `state`, `country`, `created_at`, `updated_at`, `avg_likes`, `avg_comments`, `total_comments`, `total_likes`) VALUES
(1, 2, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, 'kaimri', '135', '12501', 'hisar', 'harayana', 'india', '2023-05-17 08:23:28', '2023-05-17 08:23:28', '0', '0', '0', '0');
INSERT INTO `influencer_profiles` (`id`, `user_id`, `ig_app_id`, `ig_user_id`, `ig_app_secret`, `ig_access_token`, `ig_username`, `ig_followers`, `ig_following`, `ig_engagement_rate`, `ig_first_photo_uploaded`, `ig_last_photo_uploaded`, `street_address`, `unit_apt`, `postal_code`, `city`, `state`, `country`, `created_at`, `updated_at`, `avg_likes`, `avg_comments`, `total_comments`, `total_likes`) VALUES
(2, 5, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, '28 natronia trail', NULL, 'M9V4S3', 'Etobicoke', 'Ontario', 'Canada', '2023-05-17 14:19:04', '2023-05-24 16:25:47', '0', '0', '0', '0');
INSERT INTO `influencer_profiles` (`id`, `user_id`, `ig_app_id`, `ig_user_id`, `ig_app_secret`, `ig_access_token`, `ig_username`, `ig_followers`, `ig_following`, `ig_engagement_rate`, `ig_first_photo_uploaded`, `ig_last_photo_uploaded`, `street_address`, `unit_apt`, `postal_code`, `city`, `state`, `country`, `created_at`, `updated_at`, `avg_likes`, `avg_comments`, `total_comments`, `total_likes`) VALUES
(3, 6, NULL, '6509479059103995', NULL, 'IGQVJWNW1vU1FXM1BYNEJ6OGY4UnFCSW9fWjY0ek8yMW8xSDZAhQk9BT3lVd3FWOVhCRHowQXNseGVkMTVSS2g2azFCNzJVclhNZAFlvbGUxVjFDOE1zY2YwYmZA6MXZA3S1BJWFdZAMEh3', 'justsandy786', '0', '0', '0', NULL, NULL, '7261 Delta Cir, Austell, GA 30168, USA', 'ff6d4s5f6', '121501', 'City Electric Supply', 'Haryana', 'India', '2023-05-18 05:30:00', '2023-05-18 11:41:07', '0', '0', '0', '0');
INSERT INTO `influencer_profiles` (`id`, `user_id`, `ig_app_id`, `ig_user_id`, `ig_app_secret`, `ig_access_token`, `ig_username`, `ig_followers`, `ig_following`, `ig_engagement_rate`, `ig_first_photo_uploaded`, `ig_last_photo_uploaded`, `street_address`, `unit_apt`, `postal_code`, `city`, `state`, `country`, `created_at`, `updated_at`, `avg_likes`, `avg_comments`, `total_comments`, `total_likes`) VALUES
(4, 8, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, 'Ea impedit maiores', 'Quod distinctio Non', 'A1A 1A1', 'Hisar', 'Haryana', 'Canada', '2023-05-18 11:18:44', '2023-05-18 11:18:44', '0', '0', '0', '0'),
(5, 10, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, '247 Bath Rd, Kingston, ON K7M 2X9, Canada', '123', 'K7M 2X9', 'Kingston', 'ontario', 'Canada', '2023-05-19 08:41:01', '2023-05-19 08:41:01', '0', '0', '0', '0'),
(6, 13, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, '55 Stewart St.', 'Apt 929', 'M5V2V1', 'Toronto', 'ON', 'Canada', '2023-05-19 17:18:21', '2023-05-19 17:18:21', '0', '0', '0', '0'),
(7, 14, NULL, '5553259484774617', NULL, 'IGQVJXNGd2QncyMlM3WkU1RU5FaFBTYjNQeU05bUVySGozQU9SamRvOHJ6cklqSnRpX011d0ZAHMDZAzYkd5RE9TVlJNTHFlTkdJU1ctcFFxSTZAOTkl0bmFXMUFPbmVOblA2STZAucld3', 'ask_miku', '0', '0', '0', NULL, NULL, '28 Franca Crescent', NULL, 'M9V 4S3', 'Toronto', 'ON', 'Canada', '2023-05-19 17:23:45', '2023-05-19 17:23:54', '0', '0', '0', '0'),
(8, 18, NULL, '6156663791054215', NULL, 'IGQVJYSXRGSEZAQXzc3aEhhand6VEtlN0E0dXgtTDhOd2xMeUtxazNXWHBXcmI3aHlnbDdaODVwdGxxSDJNdGlKZAkx3cGhEY3k0ZAmttbjE1ZAGpxR2FhendJSmY5aVQ5ZAXZA3ZAkZA2Sk9R', 'vishal_patel165', '478', '253', '11.04', NULL, NULL, '12', '12', '123456', '15', 'jkjk', '12', '2023-05-24 09:59:53', '2023-05-24 11:12:42', '52.00', '1.51', '29', '1924'),
(9, 20, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, 'TTC Wilson Carhouse', 'TTC Wilson Carhouse', 'M3H 6C3', 'Toronto', 'Ontario', 'Canada', '2023-05-25 07:14:40', '2023-05-25 07:14:40', '0', '0', '0', '0'),
(10, 26, NULL, '5553259484774617', NULL, 'IGQVJXd0hhLThJQ0p6aXZAkUHZAic1NUVUpaT1Q5VmJILWotUzlDYXdlNzc2QVk4TFBNTHB0QmlwS1ZAPb0dHaVBmb1dxQ0tWalE2ZAVRQU0JoRktvVlFqeWR3OGlMUkkwaHlLT3lXSURB', 'ask_miku', '0', '0', '0', NULL, NULL, '28 Franca Crescent', '28', 'M9V 4S3', 'Toronto', 'Ontario', 'Canada', '2023-05-30 15:36:41', '2023-05-30 15:36:54', '0', '0', '0', '0'),
(11, 29, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, '3rd Street Promenade', '1234', '90401', 'Santa Monica', 'California', 'United States', '2023-05-31 04:10:19', '2023-05-31 04:10:19', '0', '0', '0', '0'),
(12, 30, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, 'Ajax Street', '5', '123556', 'Guelph', 'Ontario', 'Canada', '2023-05-31 04:12:05', '2023-05-31 04:12:05', '0', '0', '0', '0'),
(13, 31, NULL, '6156663791054215', NULL, 'IGQVJWdzZAWUVlQREFQNHpKeS12LWpWUWFtZA0VDN3BKTFZAER05sMHRRQzVMZAG5xYldBdVNMYWhPZAGd0bGVkdDQ1TVUtX0RibkxySmdNUkdybV92LU1XTW0tR0JiX25MOVNkb1ZAPTHZAn', 'vishal_patel165', '477', '253', '11.04', NULL, NULL, '120 Woodstream Blvd unit 20', 'unit 20', 'L4L 7Z1', 'Vaughan', 'Ontario', 'Canada', '2023-06-01 09:58:20', '2023-06-01 09:58:43', '52.00', '1.51', '29', '1924'),
(14, 37, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, '55 Stewart St.', '929', 'M5V2V1', 'Toronto', 'ON', 'Canada', '2023-06-02 15:40:37', '2023-06-02 15:40:37', '0', '0', '0', '0'),
(15, 39, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, '55 Stewart St.', '929', 'M5V2V1', 'Toronto', 'ON', 'Canada', '2023-06-02 18:06:20', '2023-06-02 18:06:20', '0', '0', '0', '0'),
(16, 40, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, 'Ajax Street', '5', '555555', 'Guelph', 'Ontario', 'Canada', '2023-06-05 04:27:41', '2023-06-05 04:27:41', '0', '0', '0', '0'),
(17, 41, NULL, '5553259484774617', NULL, 'IGQVJXVVEtZAGxVRGtoVmZAJanFYUkc2M0V5X05SX2VFWlNvdzJBOGplLWtneHl1Q2JKOGJzYkpJMk0yU3BBR1Y2M0NlSjllc3VhcGpxQ25fMmh3REZAZAQUlaWjk2ZAnY3OHdZAQXJjSW1n', 'ask_miku', '0', '0', '0', NULL, NULL, '120 Woodstream Blvd unit 20', 'unit 20', 'L4L 7Z1', 'Vaughan', 'Ontario', 'Canada', '2023-06-05 09:24:54', '2023-06-05 09:25:15', '0', '0', '0', '0'),
(18, 42, NULL, '5553259484774617', NULL, 'IGQVJXNS1vaHlmampMTUJ1RW5jc3gxR29KV21SM0lNNXpKbWNKN3NuZA2lfNXMyOWZAmb3ZAJRkR2S0JoWlRGTXBVNUJMWFdnV0sxNEpjczdRQTJidGhTeXdnUk51STV5c2NqM0YxaGpR', 'ask_miku', '0', '0', '0', NULL, NULL, '120 Woodstream Blvd unit 20', 'unit 20', 'L4L 7Z1', 'Vaughan', 'Ontario', 'Canada', '2023-06-06 07:05:54', '2023-06-06 07:06:13', '0', '0', '0', '0'),
(19, 43, NULL, '5553259484774617', NULL, 'IGQVJVUVJsNGlUODN4dWF1UnM5Q09UZAUVGMmR0Vjl0XzdtcHBHcTFBT2ZA3MDM4c3I5NHJ5S1lJVmJ1bTh2TXo3WmtER3VMYVVOVkRpZA0ZA1aF9hbElfbnR4MDRMd2xkemV2UGZAXUGF3', 'ask_miku', '0', '0', '0', NULL, NULL, '120 Woodstream Blvd unit 20', 'unit 20', 'L4L 7Z1', 'Vaughan', 'Ontario', 'Canada', '2023-06-06 07:09:28', '2023-06-06 07:09:49', '0', '0', '0', '0'),
(20, 44, NULL, NULL, NULL, NULL, NULL, '0', '0', '0', NULL, NULL, '6900 Airport Rd', '1234', 'L4V 1N2', 'Mississauga', 'Ontario', 'Canada', '2023-06-06 10:30:39', '2023-06-06 10:30:39', '0', '0', '0', '0');

INSERT INTO `influencer_transactions` (`id`, `user_id`, `campaign_joining_id`, `type`, `amount`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 18, 6, 1, 2.50, NULL, '2023-05-24 10:50:26', '2023-05-24 10:50:26');
INSERT INTO `influencer_transactions` (`id`, `user_id`, `campaign_joining_id`, `type`, `amount`, `deleted_at`, `created_at`, `updated_at`) VALUES
(2, 5, 7, 1, 0.00, NULL, '2023-05-24 16:19:54', '2023-05-24 16:19:54');
INSERT INTO `influencer_transactions` (`id`, `user_id`, `campaign_joining_id`, `type`, `amount`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 26, 8, 1, 2.50, NULL, '2023-05-30 19:31:18', '2023-05-30 19:31:18');
INSERT INTO `influencer_transactions` (`id`, `user_id`, `campaign_joining_id`, `type`, `amount`, `deleted_at`, `created_at`, `updated_at`) VALUES
(4, 26, 9, 1, 58.50, NULL, '2023-05-30 19:32:36', '2023-05-30 19:32:36'),
(5, 26, 10, 1, 27.50, NULL, '2023-05-31 07:20:52', '2023-05-31 07:20:52'),
(6, 31, 11, 1, 27.50, NULL, '2023-06-01 10:01:40', '2023-06-01 10:01:40'),
(7, 31, 12, 1, 40.50, NULL, '2023-06-01 10:06:18', '2023-06-01 10:06:18'),
(8, 31, 13, 1, 2.50, NULL, '2023-06-01 10:06:41', '2023-06-01 10:06:41'),
(9, 5, 14, 1, 27.50, NULL, '2023-06-01 14:26:20', '2023-06-01 14:26:20'),
(10, 5, 15, 1, 69.00, NULL, '2023-06-01 14:58:17', '2023-06-01 14:58:17'),
(11, 5, 16, 1, 2.50, NULL, '2023-06-02 13:51:53', '2023-06-02 13:51:53'),
(12, 26, 17, 1, 27.50, NULL, '2023-06-02 14:42:06', '2023-06-02 14:42:06'),
(13, 26, 18, 1, 38.00, NULL, '2023-06-02 14:42:49', '2023-06-02 14:42:49'),
(14, 26, 19, 1, 38.00, NULL, '2023-06-02 17:02:07', '2023-06-02 17:02:07'),
(15, 5, 20, 1, 38.00, NULL, '2023-06-02 18:13:34', '2023-06-02 18:13:34'),
(16, 6, 21, 1, 31.00, NULL, '2023-06-03 11:24:13', '2023-06-03 11:24:13'),
(17, 26, 22, 1, 2.50, NULL, '2023-06-06 16:06:59', '2023-06-06 16:06:59'),
(18, 10, NULL, 2, 55.00, NULL, '2023-06-07 03:21:12', '2023-06-07 03:21:12'),
(19, 10, NULL, 2, 16.00, NULL, '2023-06-07 03:21:37', '2023-06-07 03:21:37'),
(20, 10, NULL, 2, 10.00, NULL, '2023-06-07 03:22:16', '2023-06-07 03:22:16'),
(21, 10, NULL, 2, 18.00, NULL, '2023-06-07 03:22:35', '2023-06-07 03:22:35');



INSERT INTO `like_or_dislikes` (`id`, `campaign_id`, `user_id`, `like`, `created_at`, `updated_at`) VALUES
(1, 1, 6, 1, '2023-05-18 05:30:50', '2023-05-18 05:30:50');
INSERT INTO `like_or_dislikes` (`id`, `campaign_id`, `user_id`, `like`, `created_at`, `updated_at`) VALUES
(2, 2, 5, 1, '2023-05-19 02:07:01', '2023-05-19 02:07:01');
INSERT INTO `like_or_dislikes` (`id`, `campaign_id`, `user_id`, `like`, `created_at`, `updated_at`) VALUES
(3, 3, 5, 1, '2023-05-19 02:07:03', '2023-05-19 02:07:03');
INSERT INTO `like_or_dislikes` (`id`, `campaign_id`, `user_id`, `like`, `created_at`, `updated_at`) VALUES
(4, 8, 18, 1, '2023-05-24 11:17:43', '2023-05-24 11:17:43'),
(5, 6, 18, 1, '2023-05-24 11:17:47', '2023-05-24 11:17:47'),
(6, 2, 18, 1, '2023-05-24 11:19:20', '2023-05-24 11:19:20'),
(7, 8, 13, 0, '2023-05-24 12:23:37', '2023-05-24 12:23:42'),
(8, 15, 5, 1, '2023-05-24 16:25:12', '2023-05-24 16:25:12'),
(9, 4, 5, 1, '2023-05-24 16:25:13', '2023-05-24 16:25:13'),
(10, 17, 13, 0, '2023-05-26 02:52:04', '2023-05-26 02:52:05'),
(11, 20, 13, 1, '2023-05-29 02:58:52', '2023-05-29 02:58:52'),
(12, 23, 29, 0, '2023-05-31 04:12:47', '2023-05-31 04:13:01'),
(13, 24, 31, 1, '2023-06-01 10:01:50', '2023-06-01 10:01:50'),
(14, 25, 5, 1, '2023-06-01 14:59:41', '2023-06-01 14:59:41'),
(15, 25, 26, 0, '2023-06-02 14:43:09', '2023-06-02 14:43:13'),
(16, 27, 26, 0, '2023-06-02 17:00:35', '2023-06-02 17:00:36'),
(17, 2, 44, 1, '2023-06-06 10:38:54', '2023-06-06 10:38:54'),
(18, 33, 26, 1, '2023-06-06 16:06:52', '2023-06-06 16:06:52');

INSERT INTO `locations` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Canada', 1, NULL, NULL);
INSERT INTO `locations` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(2, 'USA', 0, NULL, NULL);


INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(3, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2023_04_10_083525_create_campaigns_table', 1),
(6, '2023_04_10_085916_create_images_table', 1),
(7, '2023_04_10_120724_add_dealline_and_image_column_in_campaign_table', 1),
(8, '2023_04_11_093358_add_phone_number_and_about_column_in_user_table', 1),
(9, '2023_04_18_062538_create_target_interests_table', 1),
(10, '2023_04_18_122206_add_influencer_avatar_on_users_table', 1),
(11, '2023_04_19_045825_create_campaign_objectives_table', 1),
(12, '2023_04_19_122117_create_type_of_contents_table', 1),
(13, '2023_04_19_124959_create_campaign_type_of_contents_table', 1),
(14, '2023_04_19_130324_create_objective_campaigns_table', 1),
(15, '2023_04_19_150719_create_target_interest_influencers_table', 1),
(16, '2023_04_19_152015_remove_type_of_content_and_campaign_objective_from_campaigns_table', 1),
(17, '2023_04_19_152148_remove_target_intest_from_users_table', 1),
(18, '2023_04_20_061641_create_influencer_interest_campaigns_table', 1),
(19, '2023_04_20_063158_remove_influencer_interest_column_from_campaigns_table', 1),
(20, '2023_04_20_123829_create_campaign_joinings_table', 1),
(21, '2023_04_21_040844_create_recently_viewed_campaign_table', 1),
(22, '2023_04_21_083113_create_like_or_dislikes_table', 1),
(23, '2023_04_21_084211_add_like_count_column_on_campaign_table', 1),
(24, '2023_04_22_035848_add_similiar_content_on_campaign_table', 1),
(25, '2023_04_22_063452_add_soft_delete_column_on_user_table', 1),
(26, '2023_04_24_124106_add_fb_app_id_or_fb_app_secret_and_access_token_column_on_users_table', 1),
(27, '2023_04_25_052649_renamec_columns_in_users_table', 1),
(28, '2023_04_25_062525_add_ig_user_id_in_user_table', 1),
(29, '2023_04_25_105636_create_influencer_profiles_table', 1),
(30, '2023_04_25_105914_remove_columns_in_user_table', 1),
(31, '2023_04_29_090739_insert_data_table', 1),
(32, '2023_04_29_095106_remove_type_of_content_and_campaign_objetive_from_campaigns_table', 1),
(33, '2023_05_01_025423_create_locations_table', 1),
(34, '2023_05_06_090810_create_wallets_table', 1),
(35, '2023_05_06_091003_create_transactions_table', 1),
(36, '2023_05_06_124706_add_credit_debit_column_in_transaction_table', 1),
(37, '2023_05_07_999999_add_active_status_to_users', 1),
(38, '2023_05_07_999999_add_avatar_to_users', 1),
(39, '2023_05_07_999999_add_dark_mode_to_users', 1),
(40, '2023_05_07_999999_add_messenger_color_to_users', 1),
(41, '2023_05_07_999999_create_chatify_favorites_table', 1),
(42, '2023_05_07_999999_create_chatify_messages_table', 1),
(43, '2023_05_08_053636_create_influencer_payouts_table', 1),
(44, '2023_05_08_120129_drop_column_followers_on_influencer_payout_table', 1),
(45, '2023_05_09_035114_alter_table_campaigns_change_summary', 1),
(46, '2023_05_10_034858_alter_campaign_table', 1),
(47, '2023_05_10_054801_remove_brand_name_column_from_campaign_table', 1),
(48, '2023_05_11_022110_change_column_type_on_campaign_table', 1),
(49, '2023_05_11_044407_change_column_type_on_campaign_table', 1),
(50, '2023_05_11_045629_create_subscriptions_table', 1),
(51, '2023_05_11_052709_add_subscritption_column_in_user_table', 1),
(52, '2023_05_12_041517_create_brand_profiles_table', 1),
(53, '2023_05_12_043124_create_subscription_plans_table', 1),
(54, '2023_05_12_044148_remove_table_column_from_subscription_add_new', 1),
(55, '2023_05_12_045015_create_subscription_logs_table', 1),
(56, '2023_05_12_051812_create_subscriptions_table', 1),
(57, '2023_05_13_090815_add_price_column_in_subscription_plan_table', 1),
(58, '2023_05_13_104821_add_subscription_stripe_id_in_subscriptions_table', 1),
(59, '2023_05_13_105755_add_stripe_subscription_id_column_in_subscription_logs_table', 1),
(60, '2023_05_16_054838_add_influencer_payouts_earning_slab_data', 1),
(61, '2023_05_16_060956_add_campaign_start_to_table', 1),
(62, '2023_05_16_061146_add_fields_to_influencer_profiles_table', 1),
(63, '2023_05_16_063611_add_avg_likes_to_influencer_profiles_table', 1),
(64, '2023_05_16_063621_add_avg_comments_to_influencer_profiles_table', 1),
(65, '2023_05_16_063631_add_total_comments_to_influencer_profiles_table', 1),
(66, '2023_05_16_063638_add_total_likes_to_influencer_profiles_table', 1),
(67, '2023_05_16_083331_create_jobs_table', 1),
(68, '2023_05_16_095037_alter_column_values_to_subscription_plans_table', 1),
(69, '2023_05_16_103034_remove_some_columns_from_campaigns_table', 1),
(70, '2023_05_16_122152_add_required_hashtag_and_profile_tag_to_table', 1),
(71, '2023_05_18_031714_add_tax_to_transactions_table', 2),
(72, '2023_05_18_031724_add_service_fee_to_transactions_table', 2),
(73, '2023_05_18_031730_add_service_fee_percentage_to_transactions_table', 2),
(74, '2023_05_18_031744_add_tax_percentage_to_transactions_table', 2),
(75, '2023_05_18_051529_add_campagin_name_to_transactions_table', 2),
(76, '2023_05_18_054141_alter_amount_to_transactions_table', 2),
(77, '2023_05_17_060157_create_stripe_accounts_table', 3),
(78, '2023_05_17_101332_create_campaign_hashtags_table', 4),
(79, '2023_05_17_132313_add_counts_column_to_campaigns_table', 4),
(80, '2023_05_19_080253_add_external_account_id_to_stripe_accounts_table', 5),
(81, '2023_05_20_013221_alter_foucs_of_content_to_campaigns_table', 6),
(82, '2023_05_19_120621_create_influencer_transactions_table', 7),
(83, '2023_05_21_110002_alter_requirement_to_campaigns_table', 8),
(84, '2023_05_19_092325_create_campaign_chart_data_table', 9),
(85, '2023_05_19_112134_add_impression_column_to_campaign_joinings_table', 9),
(86, '2023_05_24_112952_create_campaign_join_type_of_contents_table', 10),
(87, '2023_05_24_114216_add_campaign_type_on_campaign_joining_table', 10),
(88, '2023_05_25_090300_create_campaign_approval_contents_table', 11),
(89, '2023_05_25_114348_add_reason_column_in_campaign_approval_contents_table', 12),
(90, '2023_05_26_041417_create_cities_table', 13),
(91, '2023_05_26_095035_add_city_to_users_table', 14),
(92, '2023_05_27_112050_add_influencer_city_and_audience_city_on_campaign_table', 15),
(93, '2023_06_03_131925_add_status_column_on_locations_table', 16),
(94, '2023_06_03_135151_add_city_street_address_etc_on_campaign_joinings', 16),
(95, '2023_06_06_113612_create_notifications_table', 17);

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('0e35ce6e-aa78-490f-8114-1a898862877c', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:24', '2023-06-07 04:29:24');
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('23c262ef-e75a-4bf9-a15e-be8dc0492156', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 05:40:56', '2023-06-07 05:40:56');
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('24130c2f-c540-4b61-9075-c94431e8fa1c', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 15, '{\"name\":\"Ask Miku\",\"msg\":\"Campaign NAME 1\"}', NULL, '2023-06-06 16:06:59', '2023-06-06 16:06:59');
INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('28e33c83-8784-432f-9919-a85950e2750a', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 5, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 14:42:12', '2023-06-06 14:42:12'),
('2aeb53de-23af-4a0f-a26a-12bb25e449e6', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 26, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 16:11:52', '2023-06-06 16:11:52'),
('3448f42b-725c-4664-a1a7-0e0ead58ab6d', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 6, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:07:26', '2023-06-07 04:07:26'),
('397552d0-cbe3-45f5-ae51-bafd82e09f0d', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 05:41:55', '2023-06-07 05:41:55'),
('3b5cadb9-1a7e-44b4-b7b6-9c96a0cf591f', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 03:15:43', '2023-06-07 03:15:43'),
('3cd30e3f-8708-4178-b89e-4caa1171b40c', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:51:38', '2023-06-07 04:51:38'),
('3d8c04a0-666a-4846-9552-4a0f4d29256a', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:23', '2023-06-07 04:29:23'),
('5817fab8-ba1e-4d9f-b1db-afe50e498277', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:37:15', '2023-06-07 04:37:15'),
('5d88c97b-7236-43f2-bbf8-48c4b3bd7f3e', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:20', '2023-06-07 04:29:20'),
('5e7158e6-c559-466f-9a6d-ee6a37780d93', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 26, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 16:08:25', '2023-06-06 16:08:25'),
('5fce1493-662e-42ab-b852-87875c35d607', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 26, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 16:05:06', '2023-06-06 16:05:06'),
('63573af7-4ae5-4eb1-89b5-5fc2edfce642', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 26, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 16:08:17', '2023-06-06 16:08:17'),
('657a011a-7de0-476b-80e2-5e7db989a3ac', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 6, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 05:33:22', '2023-06-07 05:33:22'),
('67581702-dea5-4023-bbd4-2655296b72a6', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:30:15', '2023-06-07 04:30:15'),
('68f7775a-685b-46f2-9e53-3a2020124518', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 03:49:18', '2023-06-07 03:49:18'),
('722d892b-fedb-4806-8dee-87b4fb256e2a', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:32:52', '2023-06-07 04:32:52'),
('87d79b3d-573f-4c82-aa32-02188714ad17', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 26, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 16:04:58', '2023-06-06 16:04:58'),
('8fc6b815-c465-49ae-b597-29df40938fe3', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:36:25', '2023-06-07 04:36:25'),
('96533261-5252-40d1-85ed-d12cc93b30c0', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 03:32:30', '2023-06-07 03:32:30'),
('a72ad3fb-1e18-4c92-8083-f7c7501d842e', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:43:13', '2023-06-07 04:43:13'),
('a79dbc52-612d-4078-be46-c27251047063', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 05:36:50', '2023-06-07 05:36:50'),
('b3e05f4e-f8fe-4085-b0b5-1ddf39d39a46', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 03:14:24', '2023-06-07 03:14:24'),
('b675d2a9-b8a7-4b38-a58c-002f8f797bbd', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 26, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 16:08:37', '2023-06-06 16:08:37'),
('bca46032-5d32-470d-994d-f909e1357435', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:38', '2023-06-07 04:29:38'),
('c2e3c962-5b5d-4654-b4c6-763cff0c3330', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:35:18', '2023-06-07 04:35:18'),
('c78d2d99-9304-4887-8bdf-ea2d41617acf', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:55:53', '2023-06-07 04:55:53'),
('c93b0305-d67a-4740-968c-13dd3ebb7671', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:33:04', '2023-06-07 04:33:04'),
('ca959ed7-e5ef-47f3-aae5-ae33253add0e', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:15', '2023-06-07 04:29:15'),
('ccc09934-3a7c-4158-a51a-40db45ab03de', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:23', '2023-06-07 04:29:23'),
('d0ca329d-bcce-4363-8bd4-1c49ce80702d', 'App\\Notifications\\ContentForApprovalNotification', 'App\\Models\\User', 26, '{\"name\":\"Ask Miku\",\"msg\":\"Campaign NAME 1\"}', NULL, '2023-06-06 16:06:59', '2023-06-06 16:06:59'),
('d10d71b9-4c8a-4f6a-8858-9cf3893930b3', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:24', '2023-06-07 04:29:24'),
('eab4415c-de5d-4832-b762-2d8c8e9947cb', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 26, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-06 16:09:27', '2023-06-06 16:09:27'),
('fc25be3e-f226-4f77-8cf3-b244a1edc762', 'App\\Notifications\\CampaignJoinNotification', 'App\\Models\\User', 10, '{\"name\":\"vijay\",\"msg\":\"message\"}', NULL, '2023-06-07 04:29:30', '2023-06-07 04:29:30');

INSERT INTO `objective_campaigns` (`id`, `camaign_objective_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2023-05-17 00:00:00', '2023-05-17 00:00:00');
INSERT INTO `objective_campaigns` (`id`, `camaign_objective_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(2, 3, 2, '2023-05-18 00:00:00', '2023-05-18 00:00:00');
INSERT INTO `objective_campaigns` (`id`, `camaign_objective_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(3, 1, 3, '2023-05-18 00:00:00', '2023-05-18 00:00:00');
INSERT INTO `objective_campaigns` (`id`, `camaign_objective_id`, `campaign_id`, `created_at`, `updated_at`) VALUES
(4, 3, 4, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(5, 1, 5, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(6, 1, 6, '2023-05-21 00:00:00', '2023-05-21 00:00:00'),
(7, 2, 7, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(8, 1, 8, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(9, 1, 9, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(10, 1, 10, '2023-05-22 00:00:00', '2023-05-22 00:00:00'),
(11, 2, 11, '2023-05-23 00:00:00', '2023-05-23 00:00:00'),
(12, 4, 12, '2023-05-23 00:00:00', '2023-05-23 00:00:00'),
(13, 1, 13, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(14, 1, 14, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(15, 2, 14, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(16, 3, 15, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(17, 4, 15, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(18, 2, 16, '2023-05-25 00:00:00', '2023-05-25 00:00:00'),
(19, 1, 17, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(20, 2, 17, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(21, 2, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(22, 3, 18, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(23, 1, 19, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(24, 2, 19, '2023-05-26 00:00:00', '2023-05-26 00:00:00'),
(25, 1, 20, '2023-05-29 00:00:00', '2023-05-29 00:00:00'),
(26, 2, 20, '2023-05-29 00:00:00', '2023-05-29 00:00:00'),
(27, 1, 21, '2023-05-30 00:00:00', '2023-05-30 00:00:00'),
(28, 1, 22, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(29, 2, 22, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(30, 1, 23, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(31, 2, 23, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(32, 1, 24, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(33, 2, 24, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(34, 1, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(35, 2, 25, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(36, 1, 26, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(37, 2, 26, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(38, 1, 27, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(39, 2, 27, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(40, 1, 28, '2023-06-03 00:00:00', '2023-06-03 00:00:00'),
(41, 1, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(42, 2, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(43, 3, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(44, 4, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(45, 5, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(46, 6, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(47, 7, 29, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(48, 2, 30, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(49, 2, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(50, 3, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(51, 4, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(52, 5, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(53, 6, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(54, 7, 31, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(55, 2, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(56, 3, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(57, 4, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(58, 5, 32, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(59, 1, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(60, 2, 33, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(61, 3, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(62, 4, 34, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(63, 3, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00'),
(64, 4, 35, '2023-06-07 00:00:00', '2023-06-07 00:00:00');

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('pooniarupesh6500@gmail.com', '$2y$10$0xbuSzv76s4vj5VdmGd5..YQJuo4XNYXJqm57xjsPH/d8Cg.jdfXK', '2023-05-18 11:50:29');
INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('sandy.codepaper@gmail.com', '$2y$10$Qyt0i7wC6I8OEPwBnVdeVu/PulrEDOSAsML7RT/SNmZjvto/CWmNu', '2023-05-18 11:38:56');
INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('vijayjangir.codepaper@gmail.com', '$2y$10$hDfnrdVKO1GxZOskYHuivuxfImnj9Oqkxp2wL1Vbms0CYv9vE/J1.', '2023-05-31 04:07:46');



INSERT INTO `recently_viewed_campaign` (`id`, `campaign_id`, `session_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'fb3ec2e4e43bb2e863ab201ee8bec304', 5, NULL, NULL);
INSERT INTO `recently_viewed_campaign` (`id`, `campaign_id`, `session_id`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 2, 'fb3ec2e4e43bb2e863ab201ee8bec304', 5, NULL, NULL);
INSERT INTO `recently_viewed_campaign` (`id`, `campaign_id`, `session_id`, `user_id`, `created_at`, `updated_at`) VALUES
(3, 3, 'fb3ec2e4e43bb2e863ab201ee8bec304', 5, NULL, NULL);
INSERT INTO `recently_viewed_campaign` (`id`, `campaign_id`, `session_id`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 1, '863568bf00b1a5a74ba5d576fca8b78d', 13, NULL, NULL),
(5, 4, '863568bf00b1a5a74ba5d576fca8b78d', 13, NULL, NULL),
(6, 5, '863568bf00b1a5a74ba5d576fca8b78d', 13, NULL, NULL),
(9, 1, '4eddde3ce2764be8ee3c7c371c7e4692', 6, NULL, NULL),
(18, 1, 'f45198242e4b8fcc2cd180b56f89c0f0', 6, NULL, NULL),
(19, 10, 'f45198242e4b8fcc2cd180b56f89c0f0', 6, NULL, NULL),
(29, 14, 'a3894bea5c9fa06311d5723100b1d0dc', 13, NULL, NULL),
(30, 15, '0cc0c89cfb8f6fbcded1929924deb285', 5, NULL, NULL),
(31, 2, '0cc0c89cfb8f6fbcded1929924deb285', 5, NULL, NULL),
(32, 4, '0cc0c89cfb8f6fbcded1929924deb285', 5, NULL, NULL),
(33, 1, '6b781025be446c04941dbc03515bb4f9', 10, NULL, NULL),
(34, 13, '6b781025be446c04941dbc03515bb4f9', 10, NULL, NULL),
(35, 13, 'b013f4b0961440a549711a4ca1ae6ecc', 10, NULL, NULL),
(36, 15, 'b013f4b0961440a549711a4ca1ae6ecc', 10, NULL, NULL),
(37, 14, 'b013f4b0961440a549711a4ca1ae6ecc', 10, NULL, NULL),
(46, 13, 'cb41133f590e241c98c1d4dd1a041ba0', 10, NULL, NULL),
(47, 15, 'cb41133f590e241c98c1d4dd1a041ba0', 10, NULL, NULL),
(48, 17, 'cb41133f590e241c98c1d4dd1a041ba0', 10, NULL, NULL),
(49, 15, '8166b5dc73d38d1faa73e1e81bef0285', 6, NULL, NULL),
(51, 14, '8166b5dc73d38d1faa73e1e81bef0285', 6, NULL, NULL),
(52, 19, '41ddd61489b01eaf593192d0d9c57a33', 13, NULL, NULL),
(53, 6, '41ddd61489b01eaf593192d0d9c57a33', 13, NULL, NULL),
(66, 6, '9fe469ea03c025fd650550b4f11756d8', 10, NULL, NULL),
(67, 19, '898d82d98e64b6bed8c37a22024b755d', 5, NULL, NULL),
(68, 19, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(69, 20, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(70, 15, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(71, 17, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(72, 14, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(73, 6, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(74, 5, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(75, 8, '7ea0a1b82387d3470819cc83ac5c7073', 26, NULL, NULL),
(76, 23, 'e007b522768c6b20c69a39a1a6a87cb1', 29, NULL, NULL),
(82, 15, '30f7b0e6657d913998b5024ae5afe5a7', 5, NULL, NULL),
(83, 23, '30f7b0e6657d913998b5024ae5afe5a7', 5, NULL, NULL),
(84, 24, '30f7b0e6657d913998b5024ae5afe5a7', 5, NULL, NULL),
(85, 24, 'ff675b3aefb918c4faaaf1e36bb05b42', 8, NULL, NULL),
(86, 25, '30f7b0e6657d913998b5024ae5afe5a7', 5, NULL, NULL),
(87, 23, '45a8c9a6c4f0186b9ba517b52d6d9101', 5, NULL, NULL),
(88, 22, '45a8c9a6c4f0186b9ba517b52d6d9101', 5, NULL, NULL),
(89, 25, '45a8c9a6c4f0186b9ba517b52d6d9101', 5, NULL, NULL),
(90, 17, '45a8c9a6c4f0186b9ba517b52d6d9101', 5, NULL, NULL),
(92, 25, '04ec4f1ef7704d41c6daf17d494e2157', 8, NULL, NULL),
(104, 25, '3feda280b6f07be91869702bec08fef9', 5, NULL, NULL),
(105, 27, '3feda280b6f07be91869702bec08fef9', 5, NULL, NULL),
(106, 27, '55cd2380f4bdecafbe799b3baa4ed802', 5, NULL, NULL),
(107, 27, '17a1554a0bc9530e74f88c15b9b1eda0', 39, NULL, NULL),
(108, 25, '20f31c17c707ce8aa0e66d6125efe480', 6, NULL, NULL),
(111, 25, '2992094e88df28aa57e145d5428aecd4', 6, NULL, NULL),
(112, 19, 'b887ea645166edaa600aead330e015bc', 10, NULL, NULL),
(114, 27, '6e42d3a6d174c48e7942471f90967286', 5, NULL, NULL),
(117, 33, '014d2a8a74daddc0332e8cf2b65f6838', 26, NULL, NULL),
(118, 29, '014d2a8a74daddc0332e8cf2b65f6838', 26, NULL, NULL),
(119, 27, '014d2a8a74daddc0332e8cf2b65f6838', 26, NULL, NULL),
(120, 25, '014d2a8a74daddc0332e8cf2b65f6838', 26, NULL, NULL),
(126, 33, '1f98f144ba6f5eed8290623061bf6589', 10, NULL, NULL),
(127, 35, '1f98f144ba6f5eed8290623061bf6589', 10, NULL, NULL),
(128, 1, '2732e682687e55ea49ef0c28f70efa3b', 6, NULL, NULL);

INSERT INTO `stripe_accounts` (`id`, `user_id`, `account_id`, `account_holder_name`, `account_holder_type`, `account_number`, `country`, `currency`, `fingerprint`, `last4`, `routing_number`, `status`, `deleted_at`, `created_at`, `updated_at`, `external_account_id`) VALUES
(1, 5, 'acct_1N9IkkD6a10MDSLc', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-05-19 02:09:11', '2023-05-19 02:09:11', NULL);
INSERT INTO `stripe_accounts` (`id`, `user_id`, `account_id`, `account_holder_name`, `account_holder_type`, `account_number`, `country`, `currency`, `fingerprint`, `last4`, `routing_number`, `status`, `deleted_at`, `created_at`, `updated_at`, `external_account_id`) VALUES
(2, 10, 'acct_1N9PjUD73BzT37lL', 'Vishal', 'individual', '000123456789', 'CA', 'cad', 'LxQObKPr3WNCKZX5', '6789', '11000-000', 'new', NULL, '2023-05-19 09:36:21', '2023-05-19 09:38:51', 'ba_1N9PluD73BzT37lLewCTgQft');
INSERT INTO `stripe_accounts` (`id`, `user_id`, `account_id`, `account_holder_name`, `account_holder_type`, `account_number`, `country`, `currency`, `fingerprint`, `last4`, `routing_number`, `status`, `deleted_at`, `created_at`, `updated_at`, `external_account_id`) VALUES
(3, 8, 'acct_1N9U5SD1gMgIweju', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-05-19 14:15:20', '2023-05-19 14:15:20', NULL);
INSERT INTO `stripe_accounts` (`id`, `user_id`, `account_id`, `account_holder_name`, `account_holder_type`, `account_number`, `country`, `currency`, `fingerprint`, `last4`, `routing_number`, `status`, `deleted_at`, `created_at`, `updated_at`, `external_account_id`) VALUES
(4, 14, 'acct_1N9XETDG8A2qfvV8', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-05-19 17:36:51', '2023-05-19 17:36:51', NULL),
(5, 18, 'acct_1NBFZMDEq39OxCDu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-05-24 11:09:33', '2023-05-24 11:09:33', NULL),
(6, 29, 'acct_1NDgTvRhrfERc54H', 'test', 'individual', '000123456789', 'CA', 'cad', 'LxQObKPr3WNCKZX5', '6789', '11000-000', 'new', NULL, '2023-05-31 04:18:00', '2023-05-31 04:20:28', 'ba_1NDgWORhrfERc54Hdiy47IHm'),
(7, 26, 'acct_1NDjRKRY8IzZstHn', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-05-31 07:27:31', '2023-05-31 07:27:31', NULL);



INSERT INTO `subscription_plans` (`id`, `name`, `price`, `type`, `service_fee`, `stripe_price_id`, `created_at`, `updated_at`) VALUES
(1, 'Basic', 0, 'Month', 15, 'price_1N93E8Dvw9vaoZphHQXPGOaS', NULL, NULL);
INSERT INTO `subscription_plans` (`id`, `name`, `price`, `type`, `service_fee`, `stripe_price_id`, `created_at`, `updated_at`) VALUES
(2, 'Professional', 97, 'Month', 7, 'price_1N93E8Dvw9vaoZphCvHsYoqh', NULL, NULL);


INSERT INTO `subscriptions` (`id`, `user_id`, `subscription_plan_id`, `subscribe_till_date`, `stripe_sub_schedule`, `stripe_subscription_id`, `created_at`, `updated_at`) VALUES
(1, 4, 2, '2023-06-19', 'sub_1N9IJBDvw9vaoZphnw9BuMvM', 'sub_1N9IJBDvw9vaoZphnw9BuMvM', '2023-05-19 01:40:43', '2023-05-19 17:00:46');
INSERT INTO `subscriptions` (`id`, `user_id`, `subscription_plan_id`, `subscribe_till_date`, `stripe_sub_schedule`, `stripe_subscription_id`, `created_at`, `updated_at`) VALUES
(2, 9, 2, '2023-06-19', 'sub_1N9MjTDvw9vaoZphmVGqjGLU', 'sub_1N9MjTDvw9vaoZphmVGqjGLU', '2023-05-19 06:24:09', '2023-05-19 07:08:05');
INSERT INTO `subscriptions` (`id`, `user_id`, `subscription_plan_id`, `subscribe_till_date`, `stripe_sub_schedule`, `stripe_subscription_id`, `created_at`, `updated_at`) VALUES
(3, 12, 2, '2023-06-19', 'sub_1N9WkjDvw9vaoZph5jsZYa7F', 'sub_1N9WkjDvw9vaoZph5jsZYa7F', '2023-05-19 17:06:07', '2023-05-19 17:06:07');
INSERT INTO `subscriptions` (`id`, `user_id`, `subscription_plan_id`, `subscribe_till_date`, `stripe_sub_schedule`, `stripe_subscription_id`, `created_at`, `updated_at`) VALUES
(4, 15, 2, '2023-06-24', 'sub_1NA4CZDvw9vaoZphqxkkF9bg', 'sub_1NA4CZDvw9vaoZphqxkkF9bg', '2023-05-21 04:49:05', '2023-05-24 16:59:29'),
(5, 19, 2, '2023-06-24', 'sub_1NBH3dDvw9vaoZph3tnXSoF1', 'sub_1NBH3dDvw9vaoZph3tnXSoF1', '2023-05-24 12:44:50', '2023-05-24 12:44:50'),
(6, 22, 2, '2023-06-26', 'sub_1NBzL2Dvw9vaoZphN0ngWMBt', 'sub_1NBzL2Dvw9vaoZphN0ngWMBt', '2023-05-26 12:01:45', '2023-05-26 12:01:45'),
(7, 25, 2, '2023-07-01', 'sub_1NDOHODvw9vaoZphJDsRsy7g', 'sub_1NDOHODvw9vaoZphJDsRsy7g', '2023-05-30 08:51:48', '2023-06-01 10:18:09'),
(8, 27, 2, '2023-07-01', 'sub_1NDg2kDvw9vaoZphm5HEnoV8', 'sub_1NDg2kDvw9vaoZphm5HEnoV8', '2023-05-31 03:49:52', '2023-05-31 03:49:52'),
(9, 28, 2, '2023-07-01', 'sub_1NDgCeDvw9vaoZphnANpozW8', 'sub_1NDgCeDvw9vaoZphnANpozW8', '2023-05-31 04:00:06', '2023-05-31 04:00:06'),
(10, 1, 2, '2023-07-06', 'sub_1NFwauDvw9vaoZphmIu0xHF8', 'sub_1NFwauDvw9vaoZphmIu0xHF8', '2023-06-06 09:54:29', '2023-06-06 09:54:29');

INSERT INTO `target_interest_influencers` (`id`, `target_interest_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 5, 2, '2023-05-17 00:00:00', '2023-05-17 00:00:00');
INSERT INTO `target_interest_influencers` (`id`, `target_interest_id`, `user_id`, `created_at`, `updated_at`) VALUES
(2, 2, 5, '2023-05-17 00:00:00', '2023-05-17 00:00:00');
INSERT INTO `target_interest_influencers` (`id`, `target_interest_id`, `user_id`, `created_at`, `updated_at`) VALUES
(3, 24, 5, '2023-05-17 00:00:00', '2023-05-17 00:00:00');
INSERT INTO `target_interest_influencers` (`id`, `target_interest_id`, `user_id`, `created_at`, `updated_at`) VALUES
(4, 5, 6, '2023-05-18 00:00:00', '2023-05-18 00:00:00'),
(5, 2, 8, '2023-05-18 00:00:00', '2023-05-18 00:00:00'),
(6, 2, 10, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(7, 22, 13, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(8, 11, 14, '2023-05-19 00:00:00', '2023-05-19 00:00:00'),
(9, 4, 18, '2023-05-24 00:00:00', '2023-05-24 00:00:00'),
(10, 24, 20, '2023-05-25 00:00:00', '2023-05-25 00:00:00'),
(11, 1, 26, '2023-05-30 00:00:00', '2023-05-30 00:00:00'),
(12, 2, 29, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(13, 1, 30, '2023-05-31 00:00:00', '2023-05-31 00:00:00'),
(14, 2, 31, '2023-06-01 00:00:00', '2023-06-01 00:00:00'),
(15, 22, 37, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(16, 22, 39, '2023-06-02 00:00:00', '2023-06-02 00:00:00'),
(17, 1, 40, '2023-06-05 00:00:00', '2023-06-05 00:00:00'),
(18, 24, 41, '2023-06-05 00:00:00', '2023-06-05 00:00:00'),
(19, 11, 42, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(20, 7, 42, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(21, 11, 43, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(22, 7, 43, '2023-06-06 00:00:00', '2023-06-06 00:00:00'),
(23, 2, 44, '2023-06-06 00:00:00', '2023-06-06 00:00:00');

INSERT INTO `target_interests` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Art & Photography', NULL, NULL);
INSERT INTO `target_interests` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Automotive', NULL, NULL);
INSERT INTO `target_interests` (`id`, `name`, `created_at`, `updated_at`) VALUES
(3, 'Healthcare & Medicine', NULL, NULL);
INSERT INTO `target_interests` (`id`, `name`, `created_at`, `updated_at`) VALUES
(4, 'Sustainability', NULL, NULL),
(5, 'Comedy', NULL, NULL),
(6, 'Finance & Investing', NULL, NULL),
(7, 'Education & Development', NULL, NULL),
(8, 'Reading & Writing', NULL, NULL),
(9, 'Fitness', NULL, NULL),
(10, 'Lifestyle', NULL, NULL),
(11, 'Business & Technology', NULL, NULL),
(12, 'Gaming', NULL, NULL),
(13, 'Sports', NULL, NULL),
(14, 'Travel', NULL, NULL),
(15, 'Pets & Animals', NULL, NULL),
(16, 'Family & Parenting', NULL, NULL),
(17, 'Outdoors & Nature', NULL, NULL),
(18, 'Music', NULL, NULL),
(19, 'Entertainment', NULL, NULL),
(20, 'Home & Garden', NULL, NULL),
(21, 'Health & Wellness', NULL, NULL),
(22, 'Food & Drink', NULL, NULL),
(23, 'Fashion & Style', NULL, NULL),
(24, 'Beauty & Makeup', NULL, NULL),
(25, 'Other', NULL, NULL);

INSERT INTO `transactions` (`id`, `user_id`, `wallet_id`, `amount`, `status`, `description`, `debit`, `credit`, `transaction_id`, `response`, `created_at`, `updated_at`, `tax`, `service_fee`, `service_fee_percentage`, `tax_percentage`, `campaign_name`) VALUES
(1, 3, 2, 4491.07, 'succeeded', 'Wallet Top Up', NULL, '3974.3982300885', 'pi_3N960bDvw9vaoZph1rudryjn', '{\"id\":\"pi_3N960bDvw9vaoZph1rudryjn\",\"object\":\"payment_intent\",\"amount\":449107,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":449107,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3N960bDvw9vaoZph1rudryjn_secret_A9gNPzWmjqJsTJaQVa1HFVS4x\",\"confirmation_method\":\"automatic\",\"created\":1684413161,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3N960bDvw9vaoZph16Y7oqIp\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1N960zDvw9vaoZphQjkn82OD\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-18 12:33:07', '2023-05-18 12:33:07', 516.67, 0.00, 0.00, 13.00, NULL);
INSERT INTO `transactions` (`id`, `user_id`, `wallet_id`, `amount`, `status`, `description`, `debit`, `credit`, `transaction_id`, `response`, `created_at`, `updated_at`, `tax`, `service_fee`, `service_fee_percentage`, `tax_percentage`, `campaign_name`) VALUES
(2, 4, 1, 1130, 'succeeded', 'Wallet Top Up', NULL, '1000', 'pi_3N9IP2Dvw9vaoZph1Ha1uS08', '{\"id\":\"pi_3N9IP2Dvw9vaoZph1Ha1uS08\",\"object\":\"payment_intent\",\"amount\":113000,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":113000,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3N9IP2Dvw9vaoZph1Ha1uS08_secret_idLaSrJuFpMuiDwDlfnFCsSwI\",\"confirmation_method\":\"automatic\",\"created\":1684460804,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3N9IP2Dvw9vaoZph1Fdr8C8c\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1N9IPYDvw9vaoZphF3zteZyw\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-19 01:47:18', '2023-05-19 01:47:18', 130.00, 0.00, 0.00, 13.00, NULL);
INSERT INTO `transactions` (`id`, `user_id`, `wallet_id`, `amount`, `status`, `description`, `debit`, `credit`, `transaction_id`, `response`, `created_at`, `updated_at`, `tax`, `service_fee`, `service_fee_percentage`, `tax_percentage`, `campaign_name`) VALUES
(3, 4, 1, 79.1, 'succeeded', 'Wallet Top Up', NULL, '70', 'pi_3N9IZBDvw9vaoZph1hWshnFB', '{\"id\":\"pi_3N9IZBDvw9vaoZph1hWshnFB\",\"object\":\"payment_intent\",\"amount\":7910,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":7910,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3N9IZBDvw9vaoZph1hWshnFB_secret_bjatsgM6cvw8yXwpjFgcU4Ush\",\"confirmation_method\":\"automatic\",\"created\":1684461433,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3N9IZBDvw9vaoZph1bp2qHLT\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1N9IZaDvw9vaoZphv9WrRljM\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-19 01:57:40', '2023-05-19 01:57:40', 9.10, 0.00, 0.00, 13.00, NULL);
INSERT INTO `transactions` (`id`, `user_id`, `wallet_id`, `amount`, `status`, `description`, `debit`, `credit`, `transaction_id`, `response`, `created_at`, `updated_at`, `tax`, `service_fee`, `service_fee_percentage`, `tax_percentage`, `campaign_name`) VALUES
(4, 4, 1, 1070, 'succeeded', 'Campaign purchased with 7% Service Fee', '1070', '0', 'b9dzv98dvq', 'Campaign Purchased', '2023-05-19 01:58:34', '2023-05-19 01:58:34', 0.00, 70.00, 7.00, 0.00, 'Uday'),
(5, 9, 3, 113, 'succeeded', 'Wallet Top Up', NULL, '100', 'pi_3N9NfTDvw9vaoZph2dQLLmNS', '{\"id\":\"pi_3N9NfTDvw9vaoZph2dQLLmNS\",\"object\":\"payment_intent\",\"amount\":11300,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":11300,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3N9NfTDvw9vaoZph2dQLLmNS_secret_EwZ6gLBaGCYqwWjbTzdvxMKcH\",\"confirmation_method\":\"automatic\",\"created\":1684481043,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3N9NfTDvw9vaoZph2skFIhwe\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1N9Ng7Dvw9vaoZph7B3LsQyv\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-19 07:24:45', '2023-05-19 07:24:45', 13.00, 0.00, 0.00, 13.00, NULL),
(6, 9, 3, 70.62, 'succeeded', 'Campaign purchased with 7% Service Fee', '70.62', '0', 'ncfv8gwmm6', 'Campaign Purchased', '2023-05-19 10:03:26', '2023-05-19 10:03:26', 0.00, 4.62, 7.00, 0.00, 'rerer'),
(7, 12, 4, 1209.1, 'succeeded', 'Wallet Top Up', NULL, '1070', 'pi_3N9WsbDvw9vaoZph0RsZ0QK8', '{\"id\":\"pi_3N9WsbDvw9vaoZph0RsZ0QK8\",\"object\":\"payment_intent\",\"amount\":120910,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":120910,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3N9WsbDvw9vaoZph0RsZ0QK8_secret_8hfFO8LGYsm8HBujQSl3YpYXr\",\"confirmation_method\":\"automatic\",\"created\":1684516453,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3N9WsbDvw9vaoZph0EMEfqNK\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1N9WszDvw9vaoZphQKGxvcPz\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-19 17:14:38', '2023-05-19 17:14:38', 139.10, 0.00, 0.00, 13.00, NULL),
(8, 12, 4, 1070, 'succeeded', 'Campaign purchased with 7% Service Fee', '1070', '0', 'jo8lamyced', 'Campaign Purchased', '2023-05-19 17:19:14', '2023-05-19 17:19:14', 0.00, 70.00, 7.00, 0.00, 'jacksonmall'),
(9, 15, 5, 649.75, 'succeeded', 'Wallet Top Up', NULL, '575', 'pi_3NA4ADDvw9vaoZph2lY2fQw4', '{\"id\":\"pi_3NA4ADDvw9vaoZph2lY2fQw4\",\"object\":\"payment_intent\",\"amount\":64975,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":64975,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NA4ADDvw9vaoZph2lY2fQw4_secret_jS8naNWAmqZLDrwDlth9gby9S\",\"confirmation_method\":\"automatic\",\"created\":1684644397,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NA4ADDvw9vaoZph2W8V7ZbF\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NA4AUDvw9vaoZph0MWVWWjo\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-21 04:46:56', '2023-05-21 04:46:56', 74.75, 0.00, 0.00, 13.00, NULL),
(10, 15, 5, 575, 'succeeded', 'Campaign purchased with 15% Service Fee', '575', '0', '6g1r3u7bu9', 'Campaign Purchased', '2023-05-21 04:47:50', '2023-05-21 04:47:50', 0.00, 75.00, 15.00, 0.00, 'dcdd'),
(11, 15, 5, 1020, 'succeeded', 'Wallet Top Up', NULL, '850', 'pi_3NAZwuDvw9vaoZph2wDxS3Xs', '{\"id\":\"pi_3NAZwuDvw9vaoZph2wDxS3Xs\",\"object\":\"payment_intent\",\"amount\":102000,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":102000,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NAZwuDvw9vaoZph2wDxS3Xs_secret_AtRPoU5nf9To1uQaft0nfU8EK\",\"confirmation_method\":\"automatic\",\"created\":1684766580,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NAZwuDvw9vaoZph2rgaFOXc\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NAZxADvw9vaoZphlzPMTx6H\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-22 14:43:17', '2023-05-22 14:43:17', 110.50, 59.50, 7.00, 13.00, NULL),
(12, 15, 5, 850, 'succeeded', 'Campaign activated', '850', '0', 'b8crg8momk', 'Campaign activated', '2023-05-22 14:43:43', '2023-05-22 14:43:43', 0.00, 0.00, 0.00, 0.00, 'Campaign 1'),
(13, 15, 5, 44085.76, 'succeeded', 'Wallet Top Up', NULL, '34442', 'pi_3NAdDDDvw9vaoZph1hTf6yiN', '{\"id\":\"pi_3NAdDDDvw9vaoZph1hTf6yiN\",\"object\":\"payment_intent\",\"amount\":4408576,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":4408576,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NAdDDDvw9vaoZph1hTf6yiN_secret_9cHRWrdZIuUPWprSg8vO4QSpI\",\"confirmation_method\":\"automatic\",\"created\":1684779123,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NAdDDDvw9vaoZph1Ccux3kz\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NAdDXDvw9vaoZphQn0GPa1k\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-22 18:12:25', '2023-05-22 18:12:25', 4477.46, 5166.30, 15.00, 13.00, NULL),
(14, 15, 5, 34442, 'succeeded', 'Campaign activated', '34442', '0', 'bggkjjrzkt', 'Campaign activated', '2023-05-22 18:12:33', '2023-05-22 18:12:33', 0.00, 0.00, 0.00, 0.00, 'Eros Influencer Marketing'),
(15, 3, 2, 4618.29, 'succeeded', 'Wallet Top Up', NULL, '3553.8976529434', 'pi_3NAu9nDvw9vaoZph08wAKee3', '{\"id\":\"pi_3NAu9nDvw9vaoZph08wAKee3\",\"object\":\"payment_intent\",\"amount\":461829,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":461829,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NAu9nDvw9vaoZph08wAKee3_secret_nnsJuVQZQwH3tUSVXHLTWr6AE\",\"confirmation_method\":\"automatic\",\"created\":1684844259,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NAu9nDvw9vaoZph0ce5Q8JL\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NAu9yDvw9vaoZphvBEvYk6r\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-23 12:17:52', '2023-05-23 12:17:52', 531.31, 533.08, 15.00, 13.00, NULL),
(16, 3, 2, 3974.4, 'succeeded', 'Campaign activated', '3974.4', '0', 'etgb003drb', 'Campaign activated', '2023-05-23 12:23:21', '2023-05-23 12:23:21', 0.00, 518.40, 15.00, 0.00, 'sandy'),
(17, 15, 5, 747.21, 'succeeded', 'Wallet Top Up', NULL, '574.99807618315', 'pi_3NBGtjDvw9vaoZph0WnwtoxJ', '{\"id\":\"pi_3NBGtjDvw9vaoZph0WnwtoxJ\",\"object\":\"payment_intent\",\"amount\":74721,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":74721,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NBGtjDvw9vaoZph0WnwtoxJ_secret_sxfMq5roqnHqp4A1S6UFlcKOU\",\"confirmation_method\":\"automatic\",\"created\":1684931675,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NBGtjDvw9vaoZph02x4ZIak\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NBGtwDvw9vaoZphZ1r9zcti\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-24 12:34:49', '2023-05-24 12:34:49', 85.96, 86.25, 15.00, 13.00, NULL),
(18, 15, 5, 575, 'succeeded', 'Campaign activated', '575', '0', 'ti49uprgen', 'Campaign activated', '2023-05-24 12:37:02', '2023-05-24 12:37:02', 0.00, 75.00, 15.00, 0.00, 'Campaign name 2'),
(19, 19, 8, 1293.74, 'succeeded', 'Wallet Top Up', NULL, '1070.0024811844', 'pi_3NBH82Dvw9vaoZph1F8wvoQ6', '{\"id\":\"pi_3NBH82Dvw9vaoZph1F8wvoQ6\",\"object\":\"payment_intent\",\"amount\":129374,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":129374,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NBH82Dvw9vaoZph1F8wvoQ6_secret_CNlj3nkZz7uadrsEGi5dv4R1i\",\"confirmation_method\":\"automatic\",\"created\":1684932562,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NBH82Dvw9vaoZph1NMkmbxd\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NBH9sDvw9vaoZphSM5CyiSZ\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-24 12:51:18', '2023-05-24 12:51:18', 148.84, 74.90, 7.00, 13.00, NULL),
(20, 19, 8, 1070, 'succeeded', 'Campaign activated', '1070', '0', 'c8dbnfewkd', 'Campaign activated', '2023-05-24 12:51:23', '2023-05-24 12:51:23', 0.00, 70.00, 7.00, 0.00, 'My first Campaign');
INSERT INTO `transactions` (`id`, `user_id`, `wallet_id`, `amount`, `status`, `description`, `debit`, `credit`, `transaction_id`, `response`, `created_at`, `updated_at`, `tax`, `service_fee`, `service_fee_percentage`, `tax_percentage`, `campaign_name`) VALUES
(21, 4, 1, 0, 'succeeded', 'Campaign activated', '0', '0', 'ncgj2tdz00', 'Campaign activated', '2023-05-24 16:08:01', '2023-05-24 16:08:01', 0.00, 0.00, 7.00, 0.00, 'Hello');
INSERT INTO `transactions` (`id`, `user_id`, `wallet_id`, `amount`, `status`, `description`, `debit`, `credit`, `transaction_id`, `response`, `created_at`, `updated_at`, `tax`, `service_fee`, `service_fee_percentage`, `tax_percentage`, `campaign_name`) VALUES
(22, 21, 10, 280.95, 'succeeded', 'Wallet Top Up', NULL, '216.19853789919', 'pi_3NBqj3Dvw9vaoZph0pnT7IlN', '{\"id\":\"pi_3NBqj3Dvw9vaoZph0pnT7IlN\",\"object\":\"payment_intent\",\"amount\":28095,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":28095,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NBqj3Dvw9vaoZph0pnT7IlN_secret_86K7K2CdvMJluhSqGsHjonh5J\",\"confirmation_method\":\"automatic\",\"created\":1685069397,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NBqj3Dvw9vaoZph0SAexYpZ\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NBqjLDvw9vaoZphT3V5xJOl\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-26 02:50:16', '2023-05-26 02:50:16', 32.32, 32.43, 15.00, 13.00, NULL);
INSERT INTO `transactions` (`id`, `user_id`, `wallet_id`, `amount`, `status`, `description`, `debit`, `credit`, `transaction_id`, `response`, `created_at`, `updated_at`, `tax`, `service_fee`, `service_fee_percentage`, `tax_percentage`, `campaign_name`) VALUES
(23, 21, 10, 6.5, 'succeeded', 'Wallet Top Up', NULL, '5.0019238168526', 'pi_3NBqjhDvw9vaoZph03lkimbm', '{\"id\":\"pi_3NBqjhDvw9vaoZph03lkimbm\",\"object\":\"payment_intent\",\"amount\":650,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":650,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NBqjhDvw9vaoZph03lkimbm_secret_d4jOYDSjIu2gB4JJLEaRxdHHY\",\"confirmation_method\":\"automatic\",\"created\":1685069437,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NBqjhDvw9vaoZph0UticzjR\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NBqjvDvw9vaoZph6Oo0Ksff\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-26 02:50:53', '2023-05-26 02:50:53', 0.75, 0.75, 15.00, 13.00, NULL),
(24, 21, 10, 216.2, 'succeeded', 'Campaign activated', '216.2', '0', '53q9u1wz7u', 'Campaign activated', '2023-05-26 02:50:58', '2023-05-26 02:50:58', 0.00, 28.20, 15.00, 0.00, 'fghfghfghfh'),
(25, 24, 12, 1195.54, 'succeeded', 'Wallet Top Up', NULL, '920', 'pi_3NC3NsDvw9vaoZph13jQhD2g', '{\"id\":\"pi_3NC3NsDvw9vaoZph13jQhD2g\",\"object\":\"payment_intent\",\"amount\":119554,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":119554,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NC3NsDvw9vaoZph13jQhD2g_secret_sgOLePZPP5o6oBz4w5XZXp9Dk\",\"confirmation_method\":\"automatic\",\"created\":1685118056,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NC3NsDvw9vaoZph19fAv6DK\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NC3O6Dvw9vaoZphRAx7uelp\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-26 16:21:12', '2023-05-26 16:21:12', 137.54, 138.00, 15.00, 13.00, NULL),
(26, 24, 12, 920, 'succeeded', 'Campaign activated', '920', '0', '689h5d91es', 'Campaign activated', '2023-05-26 16:21:18', '2023-05-26 16:21:18', 0.00, 120.00, 15.00, 0.00, 'Starbucks Test Campaign 1'),
(27, 15, 5, 905.62, 'succeeded', 'Wallet Top Up', NULL, '749.00339095195', 'pi_3NCwHHDvw9vaoZph2fNFtqH8', '{\"id\":\"pi_3NCwHHDvw9vaoZph2fNFtqH8\",\"object\":\"payment_intent\",\"amount\":90562,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":90562,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NCwHHDvw9vaoZph2fNFtqH8_secret_Ppe4gyXGzy43Xsi0GjtDv8Ntv\",\"confirmation_method\":\"automatic\",\"created\":1685329067,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NCwHHDvw9vaoZph2taGzjba\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NCwHTDvw9vaoZphETu0Q75L\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-29 02:58:00', '2023-05-29 02:58:00', 104.19, 52.43, 7.00, 13.00, NULL),
(28, 15, 5, 749, 'succeeded', 'Campaign activated', '749', '0', '4v72iig8y7', 'Campaign activated', '2023-05-29 02:58:05', '2023-05-29 02:58:05', 0.00, 49.00, 7.00, 0.00, 'Another Campaign Name'),
(29, 27, 13, 120.91, 'succeeded', 'Wallet Top Up', NULL, '100', 'pi_3NDg3DDvw9vaoZph1Kbezwqv', '{\"id\":\"pi_3NDg3DDvw9vaoZph1Kbezwqv\",\"object\":\"payment_intent\",\"amount\":12091,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":12091,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NDg3DDvw9vaoZph1Kbezwqv_secret_6GHuWvHdenoK0oyX69q9BWPtk\",\"confirmation_method\":\"automatic\",\"created\":1685505019,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NDg3DDvw9vaoZph1kz8j6Up\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NDg3TDvw9vaoZph653mG9Re\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-31 03:50:37', '2023-05-31 03:50:37', 13.91, 7.00, 7.00, 13.00, NULL),
(30, 28, 14, 725.46, 'succeeded', 'Wallet Top Up', NULL, '600', 'pi_3NDgDIDvw9vaoZph1RjBGehe', '{\"id\":\"pi_3NDgDIDvw9vaoZph1RjBGehe\",\"object\":\"payment_intent\",\"amount\":72546,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":72546,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NDgDIDvw9vaoZph1RjBGehe_secret_iaEWDlN5cwL1EBMw1lRVonihG\",\"confirmation_method\":\"automatic\",\"created\":1685505644,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NDgDIDvw9vaoZph1VHpaIa2\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NDgDlDvw9vaoZph5ybrB9x8\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-31 04:01:15', '2023-05-31 04:01:15', 83.46, 42.00, 7.00, 13.00, NULL),
(31, 27, 13, 1209.1, 'succeeded', 'Wallet Top Up', NULL, '1000', 'pi_3NDgFIDvw9vaoZph0CDHtdKy', '{\"id\":\"pi_3NDgFIDvw9vaoZph0CDHtdKy\",\"object\":\"payment_intent\",\"amount\":120910,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":120910,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NDgFIDvw9vaoZph0CDHtdKy_secret_7ijMZpZv6nvlZluWdxDILAWve\",\"confirmation_method\":\"automatic\",\"created\":1685505768,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NDgFIDvw9vaoZph097ogDdt\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NDgFUDvw9vaoZphVd8rIYxC\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-31 04:03:01', '2023-05-31 04:03:01', 139.10, 70.00, 7.00, 13.00, NULL),
(32, 27, 13, 160.5, 'succeeded', 'Campaign activated', '160.5', '0', 'mkyka2p271', 'Campaign activated', '2023-05-31 04:03:24', '2023-05-31 04:03:24', 0.00, 10.50, 7.00, 0.00, 'Campaign Name'),
(33, 28, 14, 0, 'succeeded', 'Campaign activated', '0', '0', 'znmmoiu3h6', 'Campaign activated', '2023-05-31 04:07:06', '2023-05-31 04:07:06', 0.00, 0.00, 7.00, 0.00, 'rupesh'),
(34, 25, 15, 3627.3, 'succeeded', 'Wallet Top Up', NULL, '3000', 'pi_3NDjFkDvw9vaoZph0YjSpdzK', '{\"id\":\"pi_3NDjFkDvw9vaoZph0YjSpdzK\",\"object\":\"payment_intent\",\"amount\":362730,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":362730,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NDjFkDvw9vaoZph0YjSpdzK_secret_cA1pMMHPxyeDK9XqyEqB71SwX\",\"confirmation_method\":\"automatic\",\"created\":1685517328,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NDjFkDvw9vaoZph0axpjdD3\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NDjG1Dvw9vaoZphL85VS3zk\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-05-31 07:15:47', '2023-05-31 07:15:47', 417.30, 210.00, 7.00, 13.00, NULL),
(35, 25, 15, 2273.75, 'succeeded', 'Campaign activated', '2273.75', '0', 'c4e9ji8jtt', 'Campaign activated', '2023-05-31 07:32:54', '2023-05-31 07:32:54', 0.00, 148.75, 7.00, 0.00, 'Niyo'),
(36, 33, 16, 291.3, 'succeeded', 'Wallet Top Up', NULL, '224.1631396691', 'pi_3NECwHDvw9vaoZph0UnTQIAO', '{\"id\":\"pi_3NECwHDvw9vaoZph0UnTQIAO\",\"object\":\"payment_intent\",\"amount\":29130,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":29130,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NECwHDvw9vaoZph0UnTQIAO_secret_49FkzbOrSbtNHkdlI5lAg7erR\",\"confirmation_method\":\"automatic\",\"created\":1685631441,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NECwHDvw9vaoZph0CMqr7iz\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NECwXDvw9vaoZphWpzWTYZy\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-06-01 14:57:39', '2023-06-01 14:57:39', 33.51, 33.62, 15.00, 13.00, NULL),
(37, 33, 16, 172.5, 'succeeded', 'Campaign activated', '172.5', '0', 'k9c24vudbp', 'Campaign activated', '2023-06-01 14:57:43', '2023-06-01 14:57:43', 0.00, 22.50, 15.00, 0.00, 'uday'),
(38, 34, 17, 259.9, 'succeeded', 'Wallet Top Up', NULL, '200', 'pi_3NEaTTDvw9vaoZph2SCEPSjD', '{\"id\":\"pi_3NEaTTDvw9vaoZph2SCEPSjD\",\"object\":\"payment_intent\",\"amount\":25990,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":25990,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NEaTTDvw9vaoZph2SCEPSjD_secret_IB7gYYKsoAlg9Un2qpmYmySt1\",\"confirmation_method\":\"automatic\",\"created\":1685721911,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NEaTTDvw9vaoZph20yRatDP\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NEaTsDvw9vaoZphKcyprIRh\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-06-02 16:05:38', '2023-06-02 16:05:38', 29.90, 30.00, 15.00, 13.00, NULL),
(39, 34, 17, 200, 'succeeded', 'Campaign activated', '200', '0', 'j8b39rqks7', 'Campaign activated', '2023-06-02 16:05:45', '2023-06-02 16:05:45', 0.00, 200.00, 0.00, 0.00, 'healthy food'),
(40, 15, 5, 0, 'succeeded', 'Campaign activated', '0', '0', 'fm73yz4uad', 'Campaign activated', '2023-06-02 17:26:43', '2023-06-02 17:26:43', 0.00, 0.00, 0.00, 0.00, 'sdfsdfdsfsfs'),
(41, 1, 18, 805.69, 'succeeded', 'Wallet Top Up', NULL, '620', 'pi_3NFwUvDvw9vaoZph29P3IM5E', '{\"id\":\"pi_3NFwUvDvw9vaoZph29P3IM5E\",\"object\":\"payment_intent\",\"amount\":80569,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":80569,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NFwUvDvw9vaoZph29P3IM5E_secret_x2AqYhGpD8T1eTMsWObvWBc0V\",\"confirmation_method\":\"automatic\",\"created\":1686044897,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NFwUvDvw9vaoZph2pAagGzE\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NFwVMDvw9vaoZphLhRydTU1\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-06-06 09:48:45', '2023-06-06 09:48:45', 92.69, 93.00, 15.00, 13.00, NULL),
(42, 1, 18, 54, 'succeeded', 'Campaign activated', '54', '0', 'e62svo44s4', 'Campaign activated', '2023-06-06 10:19:32', '2023-06-06 10:19:32', 0.00, 54.00, 0.00, 0.00, 'rupesh'),
(43, 1, 18, 0, 'succeeded', 'Campaign activated', '0', '0', 's6o8bo2xwd', 'Campaign activated', '2023-06-06 10:19:50', '2023-06-06 10:19:50', 0.00, 0.00, 0.00, 0.00, 'test'),
(44, 15, 5, 1209.1, 'succeeded', 'Wallet Top Up', NULL, '1000', 'pi_3NG2MjDvw9vaoZph0Ou3hUwa', '{\"id\":\"pi_3NG2MjDvw9vaoZph0Ou3hUwa\",\"object\":\"payment_intent\",\"amount\":120910,\"amount_capturable\":0,\"amount_details\":{\"tip\":[]},\"amount_received\":120910,\"application\":null,\"application_fee_amount\":null,\"automatic_payment_methods\":null,\"canceled_at\":null,\"cancellation_reason\":null,\"capture_method\":\"automatic\",\"client_secret\":\"pi_3NG2MjDvw9vaoZph0Ou3hUwa_secret_hysX9dEwe4haTW8QEoXGcmcjn\",\"confirmation_method\":\"automatic\",\"created\":1686067453,\"currency\":\"cad\",\"customer\":null,\"description\":null,\"invoice\":null,\"last_payment_error\":null,\"latest_charge\":\"ch_3NG2MjDvw9vaoZph0DC29EVV\",\"livemode\":false,\"metadata\":[],\"next_action\":null,\"on_behalf_of\":null,\"payment_method\":\"pm_1NG2MwDvw9vaoZphQsWsfHRv\",\"payment_method_options\":{\"card\":{\"installments\":null,\"mandate_options\":null,\"network\":null,\"request_three_d_secure\":\"automatic\"}},\"payment_method_types\":[\"card\"],\"processing\":null,\"receipt_email\":null,\"review\":null,\"setup_future_usage\":null,\"shipping\":null,\"source\":null,\"statement_descriptor\":null,\"statement_descriptor_suffix\":null,\"status\":\"succeeded\",\"transfer_data\":null,\"transfer_group\":null}', '2023-06-06 16:04:28', '2023-06-06 16:04:28', 139.10, 70.00, 7.00, 13.00, NULL),
(45, 15, 5, 1000, 'succeeded', 'Campaign activated', '1000', '0', 'dxx4l7xyzl', 'Campaign activated', '2023-06-06 16:04:38', '2023-06-06 16:04:38', 0.00, 1000.00, 0.00, 0.00, 'Campaign NAME 1'),
(46, 7, 9, 0, 'succeeded', 'Campaign activated', '0', '0', '80s7543lc2', 'Campaign activated', '2023-06-07 04:39:47', '2023-06-07 04:39:47', 0.00, 0.00, 0.00, 0.00, 'dassda');

INSERT INTO `type_of_contents` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Static Post', NULL, NULL);
INSERT INTO `type_of_contents` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Carousel Post', NULL, NULL);
INSERT INTO `type_of_contents` (`id`, `name`, `created_at`, `updated_at`) VALUES
(3, 'Static Story', NULL, NULL);
INSERT INTO `type_of_contents` (`id`, `name`, `created_at`, `updated_at`) VALUES
(4, 'Video Story', NULL, NULL),
(5, 'Reels', NULL, NULL),
(6, 'Instagram Video', NULL, NULL);

INSERT INTO `users` (`id`, `company_name`, `company_url`, `person_contact`, `location`, `industry`, `brand_logo`, `about_brand`, `brand_phone_number`, `first_name`, `last_name`, `influencer_avatar`, `location_interest`, `email`, `email_verified_at`, `password`, `terms_service`, `role`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `active_status`, `avatar`, `dark_mode`, `messenger_color`, `subscription_id`, `city`) VALUES
(1, 'codepaper', 'https://www.mozilla.org/en-US/firefox/download/thanks/', 'Rupesh Kumar', '1', '1', NULL, NULL, '11111111111', NULL, NULL, NULL, NULL, 'pooniarupesh6500@gmail.com', NULL, '$2y$10$NBRqyI1X8TaRNSaM0POr/.Fbdu/h0lcoYlVbSXtgYNjU3dxLbiRRC', 1, 0, NULL, '2023-05-17 08:21:50', '2023-06-06 10:13:28', NULL, 0, 'avatar.png', 0, NULL, 2, '1');
INSERT INTO `users` (`id`, `company_name`, `company_url`, `person_contact`, `location`, `industry`, `brand_logo`, `about_brand`, `brand_phone_number`, `first_name`, `last_name`, `influencer_avatar`, `location_interest`, `email`, `email_verified_at`, `password`, `terms_service`, `role`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `active_status`, `avatar`, `dark_mode`, `messenger_color`, `subscription_id`, `city`) VALUES
(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sandy', 'Yadav', NULL, '2', 'sandyinfu.codepaper@gmail.com', NULL, '$2y$10$8eczhI2kvcE35FuI8ZIhzOoUu4OWRt78gwYOkIWswKUv3FWrD6Vrq', 1, 1, NULL, '2023-05-17 08:23:28', '2023-05-17 08:23:28', NULL, 0, 'avatar.png', 0, NULL, 1, NULL);
INSERT INTO `users` (`id`, `company_name`, `company_url`, `person_contact`, `location`, `industry`, `brand_logo`, `about_brand`, `brand_phone_number`, `first_name`, `last_name`, `influencer_avatar`, `location_interest`, `email`, `email_verified_at`, `password`, `terms_service`, `role`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `active_status`, `avatar`, `dark_mode`, `messenger_color`, `subscription_id`, `city`) VALUES
(3, 'sandy campany', 'https://app.clickup.com/t/85zrw3thw', 'Rupesh Kumar', '1', '1', 'brand/qtVxf02bAKJBsvdUH0d8ayCa4M7mJMuUR7wNkM1M.jpg', 'kjhgfd', '7027777382', NULL, NULL, NULL, NULL, 'sandybrand.codepaper@gmail.com', NULL, '$2y$10$XYJSUPK8JK2IS86A3HcIZOjriKRzem5Tnz87bPPlKpZTuqT79HXti', 1, 0, NULL, '2023-05-17 08:28:57', '2023-05-25 04:53:27', NULL, 1, 'avatar.png', 0, NULL, 1, NULL);
INSERT INTO `users` (`id`, `company_name`, `company_url`, `person_contact`, `location`, `industry`, `brand_logo`, `about_brand`, `brand_phone_number`, `first_name`, `last_name`, `influencer_avatar`, `location_interest`, `email`, `email_verified_at`, `password`, `terms_service`, `role`, `remember_token`, `created_at`, `updated_at`, `deleted_at`, `active_status`, `avatar`, `dark_mode`, `messenger_color`, `subscription_id`, `city`) VALUES
(4, 'Cp', 'https://Codepaper.com', 'Uday Patel', '1', '8', 'brand/Fo9ygxO6O0E266VYgTRXNfgyBbEF7XPRjvHJrzkd.png', 'hello there', '6475488740', NULL, NULL, NULL, NULL, 'uday@codepaper.com', NULL, '$2y$10$u4guG.JVyCUdZN3yaTjLfOk9tJvdZZf.BF9Wt7spvSqu5xqsp32Yi', 1, 0, NULL, '2023-05-17 14:01:17', '2023-05-19 17:00:46', NULL, 0, 'avatar.png', 0, NULL, 2, NULL),
(5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Uday', 'Patel', 'influencer/Nqg9cqbqUInKoqjm6hpiHDa26PPZUKBl4mUAPQK7.png', '1', 'pateluday003@gmail.com', NULL, '$2y$10$M6O/oyB604iJPZI2e5F0z.H7mTOdhAHsn0Xz5sokxrHJZ8M0kD8OW', 1, 1, NULL, '2023-05-17 14:19:04', '2023-05-24 16:25:47', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Sandy', 'yadav', NULL, '2', 'sandy.codepaper@gmail.com', NULL, '$2y$10$DwNPm27Z3PSVMOHTCc2/Se64ckS89zennY5I2JL6BJDkTrbOZLEmq', 1, 1, NULL, '2023-05-18 05:30:00', '2023-06-03 12:13:38', NULL, 1, 'avatar.png', 0, NULL, 1, NULL),
(7, 'Vishal', 'https://support.google.com/webmasters/answer/9012289?hl=en', 'Vishal', '1', '2', 'brand/O1YluuOzowAXnuCicPOgDxbHugsX98bXnRyWwx7N.webp', NULL, NULL, NULL, NULL, NULL, NULL, 'vishalshakya.codepaper@gmail.com', NULL, '$2y$10$9apoIoevzbRmiz92v2V3M.LQ5bB7r0WCxSTQpom3kvN3/2XPR4hG6', 1, 0, NULL, '2023-05-18 10:48:42', '2023-05-25 06:27:37', NULL, 0, 'avatar.png', 0, NULL, 2, NULL),
(8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Deep', 'Khicher', NULL, '1', 'deep.codepaper@gmail.com', NULL, '$2y$10$Ry7wB3/KZ4oD/6LOBT/mlOQn1V0qdD0J72Bo1sHwfT40yUl0iMYtK', 1, 1, NULL, '2023-05-18 11:18:43', '2023-05-18 11:18:43', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(9, 'newcustomer1@gmail.com', 'https://www.error.com/', 'newcustomer1', '2', '1', 'brand/MgDO01rrvb1rbee81SeuIgiaD9kkcuEhyZhfN0tQ.jpg', 'kkjkfs', '4443434430', NULL, NULL, NULL, NULL, 'newcustomer1@gmail.com', NULL, '$2y$10$Z4WcG3W04yRQnJeqSdaj1OMxFNcM6sHNWvgQ0iel9lXOlMeyysVZC', 1, 0, NULL, '2023-05-19 05:23:50', '2023-05-19 08:40:17', NULL, 1, 'avatar.png', 0, NULL, 2, NULL),
(10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Eros', 'Codepaper', NULL, '1', 'vishal.shakya991@gmail.com', NULL, '$2y$10$SnmNKsuGumNKbeDGM.Ega.qAAv9fC32j2SX8sSGLh58ABST529JOG', 1, 1, NULL, '2023-05-19 08:41:01', '2023-05-19 08:41:01', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(12, 'CP', 'Codepaper.com', 'uday patel', '1', '24', NULL, 'Leading Web Development and Custom Software Development Company based in Toronto with a goal to help your brand solve its tech problem.', NULL, NULL, NULL, NULL, NULL, 'pateluday00003@gmail.com', NULL, '$2y$10$YysfaHcvKylW36POgBdzl.eYGl1CwWRmL0Yft9rLdfJdp05Mcg7ja', 1, 0, NULL, '2023-05-19 17:03:48', '2023-05-19 17:06:07', NULL, 0, 'avatar.png', 0, NULL, 2, NULL),
(13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Apostolos', 'Toptsis', NULL, '1', 'apostolos7@gmail.com', NULL, '$2y$10$doocQa6NmsOOew/1C/w9AeA36DCcFvm/SECh0ICGmNKqNWF/GL6Nm', 1, 1, NULL, '2023-05-19 17:18:21', '2023-05-19 17:18:21', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'uday', 'patel', NULL, '1', 'pitalitejsm@gmail.com', NULL, '$2y$10$bgWh25naEd8hA9qplsYv2./5nP03zoEl8FirKjxLjjbWnioA7AKZ2', 1, 1, NULL, '2023-05-19 17:23:45', '2023-05-19 17:23:45', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(15, 'starbucks.com', 'https://www.starbucks.com/', 'Apostolos Toptsis', '1', '22', NULL, 'More than just great coffee. Explore the menu, sign up for StarbucksÂ® Rewards, manage your gift card and more.', NULL, NULL, NULL, NULL, NULL, 'hello.apostolos@gmail.com', NULL, '$2y$10$lCgAXwcWpg/a9RMKjttx.ez0tVi9HRE1w4MpiAO2x7PC7suyHzImO', 1, 0, NULL, '2023-05-21 03:26:16', '2023-05-30 19:34:28', NULL, 0, 'avatar.png', 0, NULL, 2, NULL),
(16, 'Codepaper', 'https://codepaper.com/', 'Vijay', '1', '1', NULL, 'Leading Web Development and Custom Software Development Company based in Toronto with a goal to help your brand solve its tech problem.', NULL, NULL, NULL, NULL, NULL, 'vijayjangir.codepaper@gmail.com', NULL, '$2y$10$OgjSvh20qlhgxj9wfW6w1OrZ/Wy68TdBRc5rfHezTrQGqKLUv3wIO', 1, 0, NULL, '2023-05-22 10:26:29', '2023-05-31 13:05:11', NULL, 0, 'avatar.png', 0, NULL, 1, '21'),
(17, 'Deep', 'https://codepaper.com', 'Deep Khicher', '1', '1', NULL, 'Leading Web Development and Custom Software Development Company based in Toronto with a goal to help your brand solve its tech problem.', NULL, NULL, NULL, NULL, NULL, 'deep@codepaper.com', NULL, '$2y$10$Xk2BWJiiKHyqo6UfeBo4JuMHWQIqZcKsbjPlESuB78GAYapzAlHWO', 1, 0, NULL, '2023-05-22 12:05:13', '2023-05-22 12:05:15', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Mahir', 'Patel', 'influencer/wB1Ni68n2d7HB1VVOkXnH6NH9THGR2MNg0Nn9KDq.jpg', '1', 'mahir@gmail.com', NULL, '$2y$10$EABxzaEVi/n4xiqm7VEbW.kutSXApYGLu9dRsZESJwHXZVz89z3Cy', 1, 1, NULL, '2023-05-24 09:59:53', '2023-05-24 11:12:42', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(19, 'company name 2', 'https://www.bing.com/', 'John Doe', '1', '21', NULL, 'Bing helps you turn information into action, making it faster and easier to go from searching to doing.', '4168793513', NULL, NULL, NULL, NULL, 'apostolos@erosmarketing.io', NULL, '$2y$10$A3tbIQuwV9rOALuJpwFiuOCZcc62MCXf1CFEFRvqzjqobKweJGBkq', 1, 0, NULL, '2023-05-24 12:43:08', '2023-05-24 12:44:50', NULL, 0, 'avatar.png', 0, NULL, 2, NULL),
(20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fddf', 'fdf', NULL, '1', 'superadmin@yochanahrm.com', NULL, '$2y$10$ZBX0NzHgOAnbdU3nVGdlE.pHS1pbeTHfqcDXzD9FUzWWIYySYaRCa', 1, 1, NULL, '2023-05-25 07:14:39', '2023-05-25 07:14:39', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(21, 'Google', 'https://www.google.com/', 'John Smith', '1', '24', NULL, 'Search the world\'s information, including webpages, images, videos and more. Google has many special features to help you find exactly what you\'re looking for.', '1234567897', NULL, NULL, NULL, NULL, 'email@email1.com', NULL, '$2y$10$wrgG0iHNKFoaL25tt2qc5.G3UdN1aXYc1pLdMYKDSZhMdHdzx/Cr.', 1, 0, NULL, '2023-05-26 02:47:53', '2023-05-26 02:47:53', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(22, 'codepaper', 'https://www.mozilla.org/en-US/firefox/download/thanks/', 'Rupesh Kumar', '1', '2', NULL, NULL, '07027777382', NULL, NULL, NULL, NULL, 'qwerty@gmail.com', NULL, '$2y$10$d4etURa5CDBa9oQ0Uma2wOeICQP/dkTPOtE4tHkqeYQjAD7TX98FW', 1, 0, NULL, '2023-05-26 10:35:05', '2023-05-26 12:03:39', NULL, 0, 'avatar.png', 0, NULL, 2, '1'),
(23, 'vishal.shakya991@gmail.com', 'https://www.testing.com/', 'Manoj', '1', '24', NULL, 'Testing.com is a trusted health resource designed to help patients and caregivers easily order and understand the many lab tests that are a vital part of medical care.', '9306406126', NULL, NULL, NULL, NULL, 'kalyan@yochana.com', NULL, '$2y$10$TBKXpD9KJP2pH2aQgdwGfOMFehH78Ls8ejPwBEHjgN8bJyCV.LI9C', 1, 0, NULL, '2023-05-26 10:45:40', '2023-05-26 10:45:41', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(24, 'The Best Company', 'https://www.starbucks.ca/', 'Daisy Mae', '1', '22', NULL, 'More than just great coffee and tea. Explore the menu, sign up for StarbucksÂ® Rewards, manage your gift card and more.', '4168793513', NULL, NULL, NULL, NULL, 'email@starbucks.ca', NULL, '$2y$10$9v0kVMBDaZevVpXngTbk2O9yELf2zOcdWKBuNIVkFdsxt2WHmdyg6', 1, 0, NULL, '2023-05-26 16:08:18', '2023-05-26 16:08:19', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(25, 'Niyo Global', 'https://noyo.com', 'Vishal Patel', '1', '1', 'brand/Jf006VDUvUwZ3NitgNeq5Sx0KaM5s1aqjzADfJzV.jpg', 'Noyo is the leading benefits data platform, bringing powerful automation and clean, trusted data to your software. The best benefits experiences are built on Noyo.', '9824788134', NULL, NULL, NULL, NULL, 'niyo@gmail.com', NULL, '$2y$10$SjAlP8lZy1bDHjHUs2dRDOZzua0NP8Y82rMsi9n81c45o4isIHrHm', 1, 0, NULL, '2023-05-30 08:50:56', '2023-06-01 10:18:09', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(26, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ask', 'Miku', NULL, '1', 'askmiku@gmail.com', NULL, '$2y$10$Zv/GhrZb.q7J0BQi7Ig/G.sMTRbR/fiRKXO48Wg0yx3MmxuETvALe', 1, 1, NULL, '2023-05-30 15:36:41', '2023-06-02 17:34:03', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(27, 'Codepaper', 'https://codepaper.com/', 'Vijay', '1', '1', 'brand/NCfz7UUmLvU6Dlyra9KrAK8M8EkOboXc0g2KRrdq.jpg', 'Leading Web Development and Custom Software Development Company based in Toronto with a goal to help your brand solve its tech problem.', '9876543210', NULL, NULL, NULL, NULL, 'codepaper@gmail.com', NULL, '$2y$10$nf5AKPjjKFmd1SQ1BK1Oy.WAxiBMQZh80QiT/XjDcJ.J.zUVexIGy', 1, 0, NULL, '2023-05-31 03:45:03', '2023-05-31 04:01:05', NULL, 0, 'avatar.png', 0, NULL, 2, '4'),
(28, 'codepaper', 'https://www.mozilla.org/en-US/firefox/download/thanks/', 'Rupesh Kumar', '1', '1', 'brand/7h97cspvWKQw0k6rJHwRV03yUNnR8yMLypxKG44l.jpg', 'Get Firefox for Windows, Mac or Linux. Firefox is a free web browser backed by Mozilla, a non-profit dedicated to internet health and privacy.', '07027777382', NULL, NULL, NULL, NULL, 'pooniarupesh6501@gmail.com', NULL, '$2y$10$asDQDbn0Wk/Hrw.joYN6j.a8xewBqT9KdcUIWMIAxPSs5SgLPwiTy', 1, 0, NULL, '2023-05-31 03:58:24', '2023-05-31 04:00:06', NULL, 0, 'avatar.png', 0, NULL, 2, '2'),
(29, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Rupesh', 'Kumar', NULL, '2', 'pooniarupesh6502@gmail.com', NULL, '$2y$10$LKR4.8NYxf.5O0J8k7.h/eb4mP/zmQOAJlbkGwzyPVqeycQ8XJ2C6', 1, 1, NULL, '2023-05-31 04:10:19', '2023-05-31 04:10:19', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vijay', 'Jangir', NULL, '1', 'vijayjangircodepaper@gmail.com', NULL, '$2y$10$aNfGMPl1Jn3sn3TgwL8ko.8gRctD/gCyWgdOILgUKVPfTVPWzNRNC', 1, 1, NULL, '2023-05-31 04:12:05', '2023-05-31 04:12:05', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vishal', 'Patel', '/influencer-avatar/vishal-at-codepaperdev64786bd3924ef.jpg', '2', 'vishal@codepaper.dev', NULL, '$2y$10$2eZBjri86sSC8F7mQtwPs.rI/sTMip.W8dhXwjDOhCwdE1bIiV3Su', 1, 1, NULL, '2023-06-01 09:58:20', '2023-06-01 09:58:43', NULL, 0, '/influencer-avatar/vishal-at-codepaperdev64786bd3924ef.jpg', 0, NULL, 1, NULL),
(32, 'Google', 'https://facebook.com', 'Uday Patel', '1', '11', NULL, 'Log into Facebook to start sharing and connecting with your friends, family, and people you know.', '6475488740', NULL, NULL, NULL, NULL, 'google@google.com', NULL, '$2y$10$TbUp6hWwXJRqB2X/HJI3IecnC14cHDW2vBqi0wTVlnsfg6HBPd3ne', 1, 0, NULL, '2023-06-01 14:40:58', '2023-06-01 14:40:58', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(33, 'Codepaper', 'https://Codepaper.com', 'Uday patel', '1', '1', NULL, 'Leading Web Development and Custom Software Development Company based in Toronto with a goal to help your brand solve its tech problem.', '6475488740', NULL, NULL, NULL, NULL, 'Codepaper123@gmail.com', NULL, '$2y$10$sNh9zQ7avKrHtS.Tm2fKs.x6j4Uq75IOO7kXqvi.eB12XdmB.omU6', 1, 0, NULL, '2023-06-01 14:43:58', '2023-06-01 14:43:58', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(34, 'hello foods', 'https://www.google.ca', 'jess', '1', '22', NULL, 'Search the world\'s information, including webpages, images, videos and more. Google has many special features to help you find exactly what you\'re looking for.', '4165555555', NULL, NULL, NULL, NULL, 'kf@ggg.com', NULL, '$2y$10$84FX0O4V3FEbbYBP3DLc4OahOcFVq.Uf8DgYGh/fFvoVjCUx1FKuW', 1, 0, NULL, '2023-06-02 15:32:29', '2023-06-02 16:04:21', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(35, 'COMPANY18', 'https://apple.com', 'George', '1', '1', NULL, NULL, '4168884561', NULL, NULL, NULL, NULL, 'email@emdlkfjsdlkf.com', NULL, '$2y$10$yRIZkFxbsArLGoZCvLChCu1LBURzSWhJ59T5VbaZ19JZ7.g8bmszu', 1, 0, NULL, '2023-06-02 15:35:56', '2023-06-02 15:35:56', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(36, 'COMPANY18', 'https://apple.com', 'George', '1', '1', NULL, NULL, '4168884561', NULL, NULL, NULL, NULL, 'email@gggf.com', NULL, '$2y$10$In8H0PQ.KkqbZNtCggSTR.Pwm2NMHfk.LlGl7PAqIVt700l57bh8m', 1, 0, NULL, '2023-06-02 15:37:49', '2023-06-02 15:37:49', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(37, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Georgie', 'Doepe', NULL, '1', 'georgie@email.com', NULL, '$2y$10$/A2aE6Z6AXKrvhboA2eNv.mdMvmHF9/TCE4ToiFUfiLXbwPqzo8GS', 1, 1, NULL, '2023-06-02 15:40:37', '2023-06-02 15:40:37', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(38, 'MYCOMPANY', 'https://www.linkedin.com', 'Jordan Michael', '1', '1', NULL, '750 million+ members | Manage your professional identity. Build and engage with your professional network. Access knowledge, insights and opportunities.', '4168795125', NULL, NULL, NULL, NULL, 'email@gmail.com', NULL, '$2y$10$9ZB0xQ2r3IFJPqG9g8WQUeYkEYS.pvMFFQxT.Ur/KnSduWG6BK/Vi', 1, 0, NULL, '2023-06-02 15:43:44', '2023-06-02 15:43:45', NULL, 0, 'avatar.png', 0, NULL, 1, '1'),
(39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Apostolos', 'Toptsis', NULL, '1', 'developer@erosmarketing.io', NULL, '$2y$10$FtfnwWaiNSP36DsIKl5T2e9j1ed0muREliXdzknX.hcD3Jj93rihe', 1, 1, NULL, '2023-06-02 18:06:20', '2023-06-02 18:06:20', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Influencer', 'Test', NULL, '1', 'influencer@gmail.com', NULL, '$2y$10$kkLGhyt21j1/Guh80rDm/OfAb056b5zZpvqp5.yA9tUpna1tr/S9.', 1, 1, NULL, '2023-06-05 04:27:41', '2023-06-05 04:27:41', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(41, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vishal', 'Patel', NULL, '1', 'vishalpatel165@gmail.com', NULL, '$2y$10$GRQt5YSuJPk17lRSNIlQw.GCmYGPGOHLMgahiH5JVglj7E48E5czu', 1, 1, NULL, '2023-06-05 09:24:54', '2023-06-05 09:24:54', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(42, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vishal', 'Patel', NULL, '1', 'vishalpatel1143@gmail.com', NULL, '$2y$10$BkMNInyCQfrB08UFGhfLL.LFw.yVWRH0PYIzv9YnuwFIEXwGrGWYi', 1, 1, NULL, '2023-06-06 07:05:54', '2023-06-06 07:05:54', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(43, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vishal', 'Patel', NULL, '1', 'vishalpatel0011@gmail.com', NULL, '$2y$10$1Z3Jcdn4jxtdJH6A0ApP9.rzj6SezWxjkpj6JTHaxC1ysfaKHocum', 1, 1, NULL, '2023-06-06 07:09:28', '2023-06-06 07:09:28', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(44, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'rupi', 'kumar', NULL, '1', 'qwerty1@gmail.com', NULL, '$2y$10$os5InONWNAi7aqo4rqAOPe.dQvAfK.fyy2umRYqk34pnfzuijs1Vu', 1, 1, NULL, '2023-06-06 10:30:39', '2023-06-06 10:30:39', NULL, 0, 'avatar.png', 0, NULL, 1, NULL),
(45, 'manoj', 'https://github.com/laravel-mix/laravel-mix/issues/2717', 'Manoj', '1', '11', NULL, 'Laravel Mix Version: 6.0.5 Vue Version: 2.6.12 Laravel/Lumen-Framework: 5.8 Node Version: 15.4.0 NPM Version: 7.0.15 OS: Win10 Description: I get the following error if I try to npx mix: ERROR in ./resources/js/app.js 1:0-22 Module not f...', '9306406126', NULL, NULL, NULL, NULL, 'manojkhada9@gmail.com', NULL, '$2y$10$V1cNSRbRg.dtOkuux9.A0OSTLWRz1vx/kWA8EnjK9Oj.jiLhhj0Vq', 1, 0, NULL, '2023-06-06 10:32:31', '2023-06-06 10:32:32', NULL, 0, 'avatar.png', 0, NULL, 1, '5');

INSERT INTO `wallets` (`id`, `user_id`, `amount`, `created_at`, `updated_at`) VALUES
(1, 4, 0, '2023-05-17 14:03:02', '2023-05-19 01:58:34');
INSERT INTO `wallets` (`id`, `user_id`, `amount`, `created_at`, `updated_at`) VALUES
(2, 3, 3554, '2023-05-18 07:20:42', '2023-05-23 12:23:21');
INSERT INTO `wallets` (`id`, `user_id`, `amount`, `created_at`, `updated_at`) VALUES
(3, 9, 29, '2023-05-19 06:26:13', '2023-05-19 10:03:26');
INSERT INTO `wallets` (`id`, `user_id`, `amount`, `created_at`, `updated_at`) VALUES
(4, 12, 0, '2023-05-19 17:11:59', '2023-05-19 17:19:14'),
(5, 15, 0, '2023-05-21 03:26:55', '2023-06-06 16:04:38'),
(6, 16, 0, '2023-05-23 04:35:48', '2023-05-23 04:35:48'),
(7, 17, 0, '2023-05-23 06:57:54', '2023-05-23 06:57:54'),
(8, 19, 0, '2023-05-24 12:44:56', '2023-05-24 12:51:23'),
(9, 7, 0, '2023-05-25 05:53:09', '2023-05-25 05:53:09'),
(10, 21, 5, '2023-05-26 02:48:10', '2023-05-26 02:50:58'),
(11, 23, 0, '2023-05-26 10:47:13', '2023-05-26 10:47:13'),
(12, 24, 0, '2023-05-26 16:09:07', '2023-05-26 16:21:18'),
(13, 27, 940, '2023-05-31 03:48:40', '2023-05-31 04:03:24'),
(14, 28, 600, '2023-05-31 04:00:25', '2023-05-31 04:01:15'),
(15, 25, 726, '2023-05-31 07:04:56', '2023-05-31 07:32:54'),
(16, 33, 52, '2023-06-01 14:57:15', '2023-06-01 14:57:43'),
(17, 34, 0, '2023-06-02 15:41:23', '2023-06-02 16:05:45'),
(18, 1, 566, '2023-06-06 09:40:37', '2023-06-06 10:19:32');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;