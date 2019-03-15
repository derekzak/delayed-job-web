module Delayed
  module Web
    class JobsController < Delayed::Web::ApplicationController
      def queue
        if job.can_queue?
          job.queue!
          flash[:notice] = t(:notice, scope: 'delayed/web.flashes.jobs.queued')
        else
          status = t(job.status, scope: 'delayed/web.views.statuses')
          flash[:alert] = t(:alert, scope: 'delayed/web.flashes.jobs.queued', status: status)
        end
        redirect_to "/jobs"
      end

      def destroy
        if job.can_destroy?
          job.destroy
          flash[:notice] = t(:notice, scope: 'delayed/web.flashes.jobs.destroyed')
        else
          status = t(job.status, scope: 'delayed/web.views.statuses')
          flash[:alert] = t(:alert, scope: 'delayed/web.flashes.jobs.destroyed', status: status)
        end
        redirect_to "/jobs"
      end

      def destroy_all
        for job in jobs
          if job.can_destroy?
            job.destroy
          end
        end
        flash[:notice] = t(:notice, scope: 'delayed/web.flashes.jobs.destroyed_all')
        redirect_to "/jobs"
      end

      def start_worker_daemon
        `RAILS_ENV=#{Rails.env} bin/delayed_job start`
        flash[:notice] = t(:notice, scope: 'delayed/web.flashes.jobs.start_worker_daemon')
        redirect_to "/jobs"
      end

      def stop_worker_daemon
        `RAILS_ENV=#{Rails.env} bin/delayed_job stop`
        flash[:notice] = t(:notice, scope: 'delayed/web.flashes.jobs.stop_worker_daemon')
        redirect_to "/jobs"
      end

      private

      def job
        @job ||= Delayed::Web::Job.find params[:id]
      end
      helper_method :job

      def jobs
        @jobs ||= Delayed::Web::Job.all
      end
      helper_method :jobs
    end
  end
end
