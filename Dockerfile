# Use the base image
FROM registry.suse.com/suse/sle15:15.5

# Set environment variables
ENV PATH="/opt/mambaforge/bin:${PATH}"

# Install system packages
RUN zypper --non-interactive update && \
    zypper --non-interactive install git=2.35.3 curl=8.0.1 wget=1.20.3 && \
    zypper --non-interactive install vim
    

# Install mambaforge (conda)
RUN curl -o miniforge.sh -L https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh && \
    chmod +x miniforge.sh && \
    sh miniforge.sh -b -p /opt/mambaforge && \
    rm miniforge.sh && \
    mamba install -y conda=22.11.1

# Install Python 3.10.9
# RUN conda install -y python=3.10.9
RUN mamba install -y python=3.10.9

# Install R 4.1.3
# RUN zypper --non-interactive install R-base=4.1.3
RUN mamba install -y r-base=4.1.3

# Install pip 23.0
RUN pip install --upgrade pip==23.0

# Install jupyterlab 3.4.4
RUN pip install jupyterlab==3.4.4

# Install rig 0.5.3
# RUN pip install rig==0.5.3
RUN curl -Ls https://github.com/r-lib/rig/releases/download/latest/rig-linux-latest.tar.gz | tar xz -C /usr/local/bin

# Install renv 1.0.2
RUN R -e "install.packages('renv', version='1.0.2', repos='https://cloud.r-project.org/')"

# Install ggplot2 3.4.3
RUN R -e "install.packages('ggplot2', version='3.4.3', repos='https://cloud.r-project.org/')"

# Set up working directory
WORKDIR /Users/jlu/Desktop/Transcendence/WORKDIR

# Create a base conda environment
# RUN conda create -n base_env
# RUN mamba create -n base_env python=3.10.9 r-base=4.1.3 -y
RUN mamba create -n base_env -y

# Activate the base conda environment by default
RUN echo "source activate base" >> ~/.bashrc

# Start the container
CMD ["/bin/bash"]
